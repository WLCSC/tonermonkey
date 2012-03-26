class PermissionsController < ApplicationController
	before_filter :check_for_admin
  # GET /permissions
  # GET /permissions.json
  def index
    @permissions = Permission.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @permissions }
    end
  end

  # GET /permissions/1
  # GET /permissions/1.json
  def show
    @permission = Permission.find(params[:id])

    redirect_to @permission.securable
  end

  # GET /permissions/new
  # GET /permissions/new.json
  def new
    @permission = Permission.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @permission }
    end
  end

  # GET /permissions/1/edit
  def edit
    @permission = Permission.find(params[:id])
  end

  # POST /permissions
  # POST /permissions.json
  def create
    @permission = Permission.new(params[:permission])
    @permission.principal = Principal.find(params[:principal_id])
    redirect_to @permission.securable
    @permission.save
  end

  # PUT /permissions/1
  # PUT /permissions/1.json
  def update
    @permission = Permission.find(params[:id])
    @permission.update_attributes(params[:permission])

    redirect_to @permission.securable 
  end

  # DELETE /permissions/1
  # DELETE /permissions/1.json
  def destroy
    @permission = Permission.find(params[:id])
    p= @permission.securable
    @permission.destroy
    redirect_to p
  end

  def ajax_update_principals
	@principals = Group.find(params[:principal_group]).all_principals
	render :partial => 'permissions/principal_select'
  end
end
