require 'securerandom'
require 'openssl'
require 'kconv'
require 'sqlite3'

class SqlLoginParent
  def initialize file
    @dbname=file
    initdb
    @tbl="users"
  end
  def word2hmac v,sec=@secretKey
    v||=''
    OpenSSL::HMAC.hexdigest('sha256', sec, v)
  end
  def doublehmac a,b
    sec=SecureRandom::random_bytes(32)
    r1=self.word2hmac(a,sec)
    r2=self.word2hmac(b,sec)
    r1==r2 && a==b
  end
  def login_check user,pass
    hmac1=self.word2hmac(pass)
    hmac2=self.getByUser(user)
    hmac2='x'+hmac1 if ! hmac2
    self.doublehmac(hmac1,hmac2)
  end
  def initdb
    dbf=@dbname
    STDERR.puts "db file: #{dbf}"
    @db = SQLite3::Database.new(dbf)
    @db.busy_handler{|data, retries|
      print "in busy_handler data is ",data,"\n"
      print "retries is ",retries,"\n"
      res=(retries<=3)
      if res
        sleep @@counterrwait
        retries+=1
      else
        retries=0
      end
      retries
    }
    STDERR.puts "[new db.]"
  end
  def first2do
    sql="create table #{@tbl} ( user  text, hash  text, created text)"
    @db.execute(sql)
    puts "new."
  end
  def countall
    @db.execute("select count(*) from #{@tbl}")
  rescue =>e
    puts e
    first2do
  end
  def dbq d
    SQLite3::Database.quote(d.toutf8)
  end
  def getByUser user
    user=dbq(user)
    sq="select hash from #{@tbl} where user = '#{user}'"
    res=@db.execute(sq)
    res.flatten[0]
  end
  def add user,pass
    return if user==nil || pass==nil
    user=dbq(user)
    hash=self.word2hmac(pass)
    hash=dbq(hash)
    created=Time.now.strftime("%Y/%m/%d %H:%M:%S")
    sq="select count(*) from #{@tbl} where user = '#{user}'"
    ans=@db.execute(sq)
    if ans==[[0]]
      puts @db.execute("insert into #{@tbl} (user,hash,created) values('#{user}', '#{hash}','#{created}')")
    else
      if @update
        ans=@db.execute("update #{@tbl} set hash='#{hash}' where user = '#{user}'")
        STDERR.print "!" if not $silent
      else
        STDERR.print "?" if not $silent
      end
    end
  end
  def dump
    @db.execute("select * from #{@tbl}").map{|i|i.to_s.tosjis}
  end
  def locktest
    @update=true
    @db.execute("BEGIN IMMEDIATE")
    #@db.execute("lock tables #{@tbl} write")
    while 1
#      puts self.add('00000000','test')
    end
  end
  def locktestend
    puts @db.execute("delete from #{@tbl} where date = '00000000' and title = 'test'")
  end
end

class SqlLogin < SqlLoginParent
  def initialize file
    @secretKey = 'secret key'
    super(file)
  end
end

puts 'hello, new comer.'
puts 'user:'
user=gets.chomp
puts 'pass:'
pass=gets.chomp


db=SqlLogin.new('logindb.db')
p db.countall
db.add(user,pass)
