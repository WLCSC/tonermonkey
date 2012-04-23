class Item < ActiveRecord::Base
	has_many :inventories
	has_many :stores, :through => :inventories
	has_many :item_orders
	has_many :orders, :through => :item_orders

	class << self
		def unsafe_items
			Item.all.delete_if{|i| i.count_all <= (i.unsafe ? i.unsafe : 0)}
		end

		def need_items
			Item.all.delete_if{|i| i.count_all <= (i.target ? i.target : 0)}
		end
	end

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

	def safe?
		self.count_all > (self.unsafe || 0)
	end

	def need?
		self.count_all <= (self.target || 0)
	end
end
