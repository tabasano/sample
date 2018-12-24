# create table: name => 'tbl' values => ( name, c1, c2, c3, ... ) 
tbl=ARGV[0]
n=ARGV[1].to_i

str=[]
n.times{|i|
  str<<"c#{i+1} int"
}
str=str*','
sql="create table #{tbl} (name varchar(12),%s);" % str
puts sql
