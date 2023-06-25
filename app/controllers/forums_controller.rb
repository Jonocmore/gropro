class ForumsController < ApplicationController
  def index
    @forum = Forum.all
    @user = current_user
    @user_forum = @forum.where(user_id: @user)
  end

  def show
    @forum = Forum.find(params[:id])
    @message = Message.new
  end
end
