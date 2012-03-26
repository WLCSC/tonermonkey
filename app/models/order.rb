class Order < ActiveRecord::Base
	belongs_to :user
	belongs_to :store
	has_many :item_orders
	has_many :items, :through => :item_orders
	accepts_nested_attributes_for :item_orders
	attr_accessor :tag, :change_type
	before_create :check_tag
	after_create :create_tag

	def check_tag
		@r = nil
		q = Item.where(:barcode => self.tag)
		if q.length == 1
			@r = q.first
		end
		q = Item.where(:short => self.tag)
		if q.length == 1
			@r = q.first
		end
		q = Item.where(:name => self.tag)
		if q.length == 1
			@r = q.first
		end
	end

	def create_tag
		if @r
			ItemOrder.create!(:item_id => @r.id, :order_id => self.id, :change_type => self.change_type, :change => -1)
		end
	end
end
