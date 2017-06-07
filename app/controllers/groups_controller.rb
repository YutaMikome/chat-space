class GroupsController < ApplicationController
  def new
    @group = Group.new
    # binding.pry
  end

  def edit
    @group = Group.new
  end

  private
  def group_params
    params.permit(:name)
  end
end
