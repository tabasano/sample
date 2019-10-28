def ispoint str
  str=~/^\s*([0-9.]+ *)+$/
end
def getpoint str,rate
  s=str.scan(/[0-9.]+/)
  p s
  s.map{|i|p i;i ? i.to_f*rate : i}
end
file=ARGV[0]
rate=ARGV[1].to_f
rate=1 if rate==0
p file,rate

data=File.readlines(file)
pos=[]
flag=false
mesh=false
tri=false
tricount=0
first=false
data.each{|i|
  i=~/(\/)?Position/
  flag=true if $&
	  (flag=false; pos << "----") if $1 && first && pos.size>0 && pos[-1].class==Array
  if i=~/Mesh types.*(triangles|)/
    tri=$1
    STDERR.puts [:tri,tri]
  end
  next if !flag
  STDERR.puts i
  if ispoint(i)
    xyz = getpoint(i,rate)
    pos << xyz
    if tri
      first = xyz if tricount%3==0
      STDERR.puts :tripos
      pos << first << "---" if tricount%3==2
      tricount+=1
    end
  end
}
pos.each{|point|
  if point.class==Array
    puts point*","
  else
    puts point
  end
}

