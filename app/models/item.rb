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
end
