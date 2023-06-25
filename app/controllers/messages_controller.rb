class MessagesController < ApplicationController
  def create
    @forum = Forum.find(params[:forum_id])
    @message = Message.new(message_params)
    @message.forum = @forum
    @message.user = current_user

    if @message.save
      redirect_to forum_path(@forum)
    else
      render "forums/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
