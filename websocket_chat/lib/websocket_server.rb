#!/usr/bin/env ruby
require 'rubygems'
require 'em-websocket'

#コネクションはDBに格納する#TODO
connections = []
#過去ログもDBに保存する#TODO
prevMsgs = []

#:hostはサーバーのdomain
#production環境にする場合は:debug => falseとする
EventMachine::WebSocket.start(:host => "0.0.0.0", :port => 8080, :debug => true) do |ws|
  ws.onopen do
    connections.push(ws) unless connections.index(ws)
    if ARGV[0] == '--cache'
      prevMsgs.each do |prevMsg|
        ws.send(prevMsg)
      end
    end
  end

  ws.onmessage do |msg|
    msgs = msg.split(':')

    if msgs[0] != '' && ARGV[0] == '--cache'
      prevMsgs.delete_if{|prevMsg| msg == prevMsg} #この部分はいらないかも
      prevMsgs.push(msg)
    end 

    connections.each do |con|
      con.send(msg) unless con == ws #送信元以外のconnectionに送信
    end
  end

  ws.onclose do
    connections.delete_if{|con| con == ws} #削除元のコネクションをconnections配列から消す
  end
end
