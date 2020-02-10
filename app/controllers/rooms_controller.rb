class RoomsController < ApplicationController
  before_action :room_check, only: [:dm_create]

  def dm_create
    if @c.count == 0
      room = Room.new
      room.name = nil
      room.save
      current_user.user_rooms.create(room_id: room.id)
      @user.user_rooms.create(room_id: room.id)
      redirect_to room_path(room)
    else 
      room = @c[0]
      redirect_to room_path(room)
    end
  end

  def show
    @room = Room.find(params[:id])
    @posts = @room.posts
    @room.users.each do |user|
      if user.id != current_user.id
        @user = User.find(user.id)
      end
    end
  end

  private
  
  def room_params
    params.require(:room).permit(:name)
  end

  # すでにdmをしたことのある２人ならroomを作成せず、すでに存在するroomのshowへと飛ばす
  def room_check
    @user = User.find(params[:id])
    @a = []
    @b = []
    current_user.user_rooms.each do |room|
      if room.room.name == nil
        @a.push(room.room_id)
      end
    end
  
    @user.user_rooms.each do |room|
      if room.room.name == nil
        @b.push(room.room_id)
      end
    end
    @c = @a & @b
  end

end
