class User < ActiveRecord::Base
	has_many :memberships
has_many :groups, :through => :memberships
has_one :principal, :as => :authorizable
has_many :permissions, :through => :principal
has_many :managers
	after_create :create_principal

	def create_principal
		self.build_principal.save
	end

	def belongs_to? group
		group.users.include? self
	end

	def member_of? group
		belongs_to? group
	end

	def stores
		if self.admin?
			Store.all
		else
			stores = []
			Store.all.each do |s|
				stores << s if s.secures self
			end
			stores
		end
	end

	def admin?
		self.administrator
	end
end
