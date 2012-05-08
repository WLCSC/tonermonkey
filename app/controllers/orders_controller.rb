class OrdersController < ApplicationController
	before_filter :check_for_user, :except => [:quick]
	# GET /orders
	# GET /orders.json
	def index
		@orders = Order.all

		respond_to do |format|
			format.html # index.html.erb
			format.json { render json: @orders }
		end
	end

	# GET /orders/1
	# GET /orders/1.json
	def show
		@order = Order.find(params[:id])

		respond_to do |format|
			format.html # show.html.erb
			format.json { render json: @order }
		end
	end

	# GET /orders/new
	# GET /orders/new.json
	def new
		@order = Order.new

		respond_to do |format|
			format.html # new.html.erb
			format.json { render json: @order }
		end
	end

	# GET /orders/1/edit
	def edit
		@order = Order.find(params[:id])
	end

	# POST /orders
	# POST /orders.json
	def create
		@order = Order.new(params[:order])
		@orders = {}
		@order.item_orders.each do |io|
			if io.store_id != @order.store_id
				unless @orders[io.store_id]
					@orders[io.store_id] = Order.new(:user_id => @order.user_id, :store_id => io.store_id)
				end
				io.order = @orders[io.store_id]
				io.save
			end
		end

		respond_to do |format|
			if @orders.each{|i,x| x.save}
				@orders.each do |i,order|
					order.store.managing_users.each do |u|
						Mailman.order_email(order, current_user, u).deliver
					end
					order.store.items.each do |item|
						unless item.safe?
							User.where(:administrator => true).each do |u|
								Mailman.unsafe_email(order,item, u).deliver
							end			
						end
					end
				end
				format.html { redirect_to @order, notice: 'Order was successfully created.' }
				format.json { render json: @order, status: :created, location: @order }
			else
				format.html { render action: "new" }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
	end

	# PUT /orders/1
	# PUT /orders/1.json
	def update
		@order = Order.find(params[:id])

		respond_to do |format|
			if @order.update_attributes(params[:order])
				format.html { redirect_to @order, notice: 'Order was successfully updated.' }
				format.json { head :no_content }
			else
				format.html { render action: "edit" }
				format.json { render json: @order.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /orders/1
	# DELETE /orders/1.json
	def destroy
		@order = Order.find(params[:id])
		@order.destroy

		respond_to do |format|
			format.html { redirect_to orders_url }
			format.json { head :no_content }
		end
	end

	def use
		@order = Order.new
	end

	def quick
		if(params[:username])
			user = User.where(:username => params[:username]).first
			store = Store.where(:name => params[:store]).first
		else
			user = User.find(params[:user_id])
			store = Store.find params[:store_id]
		end
		
		i = Item.find_tag params[:item_tag]
		if i
			order = Order.create!(:user_id => user.id, :store_id => store.id)
			ItemOrder.create!(:item_tag => params[:item_tag],  :order_id => order.id, :change => -1, :change_type => 'use')
		end
		render :nothing
	end
end
