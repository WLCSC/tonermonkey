class Item < ActiveRecord::Base
	has_many :inventories
	has_many :stores, :through => :inventories
	has_many :item_orders
	has_many :orders, :through => :item_orders

	def count_all
		total = 0
		self.inventories.each do |i|
			total += i.count
		end
		total
	end

	def Item.find_tag i
		@r = nil
		q = Item.where(:barcode => i)
		if q.length >= 1
			@r = q.first
		end
		q = Item.where(:short => i)
		if q.length >= 1
			@r = q.first
		end
		q = Item.where(:name => i)
		if q.length >= 1
			@r = q.first
		end
		@r
	end
end
