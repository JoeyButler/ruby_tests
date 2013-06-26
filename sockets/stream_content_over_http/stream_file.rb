require 'rubygems'
require 'xmlsimple'
require 'socket'
require 'pry'

def print_node(node)
  p XmlSimple.xml_in(node)
rescue REXML::ParseException
  puts "Error parsing the following string."
  p node
end

# The following are the headers to the live site. This is useful for testing
# against the real thing. For some reason on localhost the last chunk pauses
# for a few seconds. Maybe something to do with the loopback interface.
# GET /rss/news.xml HTTP/1.1
# Host: www.dol.gov

http_get = "GET / HTTP/1.1\r
Host: localhost:4567\r
Connection: keep-alive\r\n\r\n"

socket = TCPSocket.new('127.0.0.1', 4567)
socket.write(http_get)

previous_buffer = ''
while buffer = socket.read(4096)
  if previous_buffer =~ /<item>/
    buffer = previous_buffer.gsub(/^[\r\n>-]+/, '') + buffer
  end

  while (start_index = buffer =~ /<item>/) && buffer =~ /<\/item>/
    buffer = buffer.slice(start_index, buffer.size)
    scanner = StringScanner.new(buffer)
    node = scanner.scan_until(/<\/item>/)
    print_node node if node
    buffer = buffer.slice(scanner.pos, buffer.size)
  end
  previous_buffer = buffer
end

