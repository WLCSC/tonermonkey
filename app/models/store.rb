class Store < ActiveRecord::Base
	has_many :inventories
	has_many :items, :through => :inventories
	has_many :orders
	has_many :item_orders, :through => :orders
	has_many :managers
	has_many :users, :through => :managers
	has_many :permissions, :as => :securable
	has_many :principals, :through => :permissions

	def secures user
		self.permissions.sort{|a,b| a.priority <=> b.priority}.each do |p|
			if (p.authorizes? user) && (p.key == "access") && (p.value == 1)
				return p
			end
		end
		nil
	end

	def secures_without user, skip
		self.permissions.sort{|a,b| a.priority <=> b.priority}.each do |p|
			return p if p.authorizes? user && p != skip
	end
	end

	def users
		self.principals.map {|x| x.users}.flatten.uniq
	end

	def can? user, right
		p = self.permissions.where(:user_id => user.id).where(:key => right).order('priority').first
		p.value == 1
	end

	def permissions
		Permission.where(:securable_type => "Store").where(:securable_id => self.id)
	end

	def managing_users
		self.managers.map {|m| m.user}
	end
end
