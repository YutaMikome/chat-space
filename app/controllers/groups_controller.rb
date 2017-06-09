class GroupsController < ApplicationController
  
  before_action :get_group, only:[:edit,:update]

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def update
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
    params.require(:group).permit(:name, {user_ids:[]})
  end

  def get_group
    @group = Group.find(params[:id])
  end
end
