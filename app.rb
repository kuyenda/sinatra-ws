require 'sinatra'
require 'sinatra-websocket'
require "sinatra/reloader" if development?

configure do
  set :server, 'thin'
  set :sockets, []
end

helpers do
  def mark
    Time.now.strftime("%M: %S") + "(#{request.ip})"
  end
  def broadcast(message)
    EM.next_tick do
      settings.sockets.each do |socket|
        socket.send(message)
      end
    end
  end
  def pong
    # Do nothing
  end
end

get '/' do
  if !request.websocket?
    erb :index
  else
    request.websocket do |ws|
      ws.onopen do
        settings.sockets << ws
        broadcast("#{mark} 加入！")
      end
      ws.onmessage do |message|
        if message!="ping"
          broadcast("#{mark} 说：#{message}")
        else
          pong
        end
      end
      ws.onclose do
        broadcast("#{mark} 离开了...")
        settings.sockets.delete(ws)
      end
    end
  end
end
