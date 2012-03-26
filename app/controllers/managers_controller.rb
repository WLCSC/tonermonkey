class ManagersController < ApplicationController
	before_filter :check_for_admin
  def create
	  @manager = Manager.new
	  @manager.store_id = params[:store_id]
	  @manager.user_id = params[:user_id]
	  if @manager.save
		  redirect_to @manager.store, :notice => "Added manager."
	  else
		  redirect_to @manager.store, :error => "Failed to add manager."
	  end
  end

  def destroy
	  @manager = Manager.find params[:id]
	  @store = @manager.store
	  @manager.destroy
	  redirect_to @store, :notice => "Removed manager."
  end
end
