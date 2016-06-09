require "bundler/setup"
Bundler.require(:default)
require 'sinatra'
require 'resque/server'
require 'resque/scheduler'
require 'resque/scheduler/server'
require 'yaml'

options = JSON.parse(File.read('/tmp/config.json'))

if (options['sentinels'] != nil && options['sentinels'].is_a?(Array) && options['sentinels'].length > 0 && options['master'] != nil)
  puts 'Running with sentinel configuration'
  
  sentinels = []
  
  options['sentinels'].each do | sentinel |
    conf = sentinel.split(':')
        
    sentinels.push({
      :host => conf[0],
      :port => conf[1].to_i
    })
  end
    
  Resque.redis = Redis.new(
    :url => "redis://" + options['master'],
    :sentinels => sentinels,
    :role => :master,
    :db => options['db']
  )
elsif (options['redis'] != nil)
  puts 'Running with custom redis configuration'
  
  Resque.redis = Redis.new(
    :host => options['redis'], 
    :port => options['port'], 
    :db   => options['db']
  )
else
  puts 'Running with default configuration'
  
  Resque.redis = Redis.new(
    host: '127.0.0.1', 
    port: 6379, 
    db: 0
  )
end
  
run Rack::URLMap.new \
  "/" => Resque::Server.new