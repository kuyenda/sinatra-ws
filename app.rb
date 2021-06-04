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
end

get '/' do
  if !request.websocket?
    erb :index
  else
    request.websocket do |ws|
      ws.onopen do
        ws.send("#{mark} 加入！")
        settings.sockets << ws
      end
      ws.onmessage do |message|
        EM.next_tick do
          settings.sockets.each do |socket|
            socket.send("#{mark} 说：#{message}")
          end
        end
      end
      ws.onclose do
        ws.send("#{mark} 离开！")
        settings.sockets.delete(ws)
      end
    end
  end
end
