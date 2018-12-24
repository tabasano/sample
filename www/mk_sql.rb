# insert test data: table name => 'tbl' values => ( name, c1, c2, c3, ... )
#   name => from 1 to clm (a_1,a_2.a_3, ... )
#   rows => set random numbers to c1,c2, ...

def mkOne tbl,clmnum,u,v
  str=[]
  clmnum.times{|i|
    str<<"c#{i+1}"
  }
  clm=str*','
  sql="insert into #{tbl} (name, #{clm}) values(\"%s\", %s);" % [u,v]
  puts sql
end
tbl=ARGV[0]
clm=ARGV[1].to_i
user=ARGV[2]
num=ARGV[3].to_i
num.times{|i|
  str=[]
  clm.times{|i|
    str<<"#{rand(i+1000)}"
  }
  v=str*','
  mkOne(tbl,clm,"#{user}_#{i}",v)
}

