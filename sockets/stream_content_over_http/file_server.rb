require 'rubygems'
require 'sinatra'

enable :run
get '/' do
  puts 'oh hai'
  send_file File.new('./news.xml')
end
