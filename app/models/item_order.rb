class ItemOrder < ActiveRecord::Base
	belongs_to :order
	belongs_to :item
	attr_accessor :item_tag, :store_id
	has_one :store, :through => :order
	before_create :find_tag
	after_save :update_store
	before_update :remove_from_store
	before_save :fix_change
	validates_each :item_tag do |record, attr, value|
		record.errors.add(attr, "#{value} doesn't exist") unless (Item.find_tag(value))
	end


	def fix_change
		self.change *= -1 if (['return', 'use', 'stxfr'].include?(self.change_type) && self.change >= 0) || (['new', 'replace', 'rtxfr'].include?(self.change_type) && self.change <= 0)
	end

	def find_tag
		q = Item.where(:barcode => self.item_tag)
		if q.length == 1
			self.item = q.first
		end
		q = Item.where(:short => self.item_tag)
		if q.length == 1
			self.item = q.first
		end
		q = Item.where(:name => self.item_tag)
		if q.length == 1
			self.item = q.first
		end
	end

	def type=(t)
		this.type = t
	end

	def update_store
		i = self.store.inventories.where(:item_id => self.item_id).first
		unless i
			i = Inventory.create!(:item_id => self.item_id, :store_id => self.order.store_id, :count => 0)
		end
		i.count += self.change
		i.save
	end

	def remove_from_store
		i = self.store.inventories.where(:item_id => self.item_id).first
		unless i
			i = Inventory.create!(:item_id => self.item_id, :store_id => self.order.store_id, :count => 0)
		end
		i.count -= self.change
		i.save
	end
end
