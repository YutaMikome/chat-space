class MessagesController < ApplicationController
  before_action :get_group, only: [:index, :create]

  def index
    @message = Message.new
  end

  def create
    @message = @group.messages.new(message_params)
    if @message.save
      flash[:notice] = "メッセージ投稿が完了しました。"
      redirect_to group_messages_path
    else
      flash[:alert] = "メッセージを入力してください。"
      render "index"
    end
  end

  private
  def message_params
    params.require(:message).permit(:body, :image).merge(user_id: current_user.id)
  end

  def get_group
    @groups = current_user.groups
    @group = Group.find(params[:group_id])
  end
end
