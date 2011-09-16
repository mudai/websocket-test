#!/usr/bin/env ruby
require 'rubygems'
require 'em-websocket'

if ARGV[0].nil?
  puts "pid file path not found !!"
  exit 1
else
  pidfile = ARGV[0]
end

Process.daemon
File.open( pidfile, "w") {|pid| pid.write Process.pid }

#コネクションはDBに格納する#TODO
connections = []
#過去ログもDBに保存する#TODO
prevMsgs = []

#:hostはサーバーのdomain
#production環境にする場合は:debug => falseとする
config = configatron.websocket.to_hash
EventMachine::WebSocket.start(config) do |ws|
  puts "server start"
  ws.onopen do
    puts "on open"
    connections.push(ws) unless connections.index(ws)
    prevMsgs.each do |prevMsg|
      ws.send(prevMsg)
    end
  end

  ws.onmessage do |msg|
    p connections
    p msg
    puts "on message"
    prevMsgs.push(msg)
    puts msg
    connections.each do |con|
      con.send(msg)
    end
  end

  ws.onclose do
    puts "on close"
    connections.delete_if{|con| con == ws} #削除元のコネクションをconnections配列から消す
  end
end
