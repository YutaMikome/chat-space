class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def edit
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)

    if @group.save
      flash[:notice] = "チャットグループが作成されました。"
      redirect_to root_path
    else
      flash[:alert] = "チャットグループの作成に失敗しました。"
      render :new
    end
  end


  private
  def group_params
    params.require(:group).permit(:name)
  end
end
