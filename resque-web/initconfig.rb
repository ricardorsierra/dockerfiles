#!/usr/bin/env ruby

require 'optparse'
require 'json'
require 'ostruct'

options = {
  'sentinels' => [],
  'redis' => '127.0.0.1',
  'master' => 'mymaster',
  'port'  => 6379,
  'db'    => 0
}

OptionParser.new do |opt|
  opt.on('--sentinel=SENTINEL:PORT', String, 'Sentinel connection in form of sentinel:port') do |sentinel| options['sentinels'].push(sentinel) end
  opt.on('--master=MASTER', String, 'redis sentinel master') do |master| options['master'] = master end
  opt.on('--redis=REDIS', String, 'redis host') do |redis| options['redis'] = redis end
  opt.on('--port=PORT', Integer, 'redis port') do |port| options['port'] = port end
  opt.on('--db=DB', Integer, 'redis db number') do |db| options['db'] = db end
end.parse!(ARGV)

File.open("/tmp/config.json","w") do |f|
  f.write(options.to_json)
end

