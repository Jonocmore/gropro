class MessagesController < ApplicationController
  def create
    @forum = Forum.find(params[:forum_id])
    @message = Message.new(message_params)
    @message.forum = @forum
    @message.user = current_user

    if @message.save
      ForumChannel.broadcast_to(
        @forum,
        message: render_to_string(partial: "message", locals: { message: @message }),
        sender_id: @message.user.id
      )
      head :ok
    else
      render "forums/show", status: :unprocessable_entity
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
