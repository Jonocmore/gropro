class ForumChannel < ApplicationCable::Channel
  def subscribed
    forum = Forum.find(params[:id])
    stream_for forum
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
