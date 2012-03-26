class UsersController < ApplicationController
	before_filter :check_for_admin
  def index
	  @users = User.all
  end

  def edit
  end

  def update
  end
end
