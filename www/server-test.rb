require 'webrick'
include WEBrick

print 'address: '
address=gets.chomp
print 'port: '
port=gets.chomp

s = HTTPServer.new(
:BindAddress =>address,
:DocumentRoot => File.join(Dir.pwd, "www"),
:Port => port
)
trap("INT") { s.shutdown }
s.start
