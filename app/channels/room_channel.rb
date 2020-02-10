class RoomChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # 接続された時
    stream_from 'room_channel'
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    # 切断された時
  end

  def speak(message)
    post = Post.new(message: message['message'][0], user_id: message['message'][1].to_i, room_id: message['message'][2].to_i)
    post.save
    ActionCable.server.broadcast 'room_channel', message: message['message'][0] # フロントへ返します
  end
end