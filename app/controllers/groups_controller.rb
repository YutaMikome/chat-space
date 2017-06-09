class GroupsController < ApplicationController
  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    @group = Group.find(params[:id])

    if @group.update(group_params)
      flash[:notice] = "チャットグループが更新されました。"
      redirect_to root_path
    else
      flash[:alert] = "チャットグループの更新に失敗しました。"
      render :edit
    end
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
