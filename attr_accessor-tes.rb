def func a
  # Kernel.format("%02x",a)
  format("%02x",a)
end
p func(3)
p func(4)

class A
  attr_accessor :format, :abcd
  def initialize
    @abcd=8
  end
  def try a
    func(a)
  end
end

p defined?(format)
p format("%02x",5)
v=A.new
p format("%02x",6)
p defined?(format)
p defined?(abcd)
p v.abcd
p v.try(7)
