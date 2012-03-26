class Principal < ActiveRecord::Base
	has_many :permissions
belongs_to :authorizable, :polymorphic => :true

	def nice_name
		if self.authorizable.is_a? User
			"U#{self.authorizable.admin? ? "!" : ""}:#{self.authorizable.name}"
		else
			"G(#{self.authorizable.users.count}):#{self.authorizable.name}"
		end
	end

	def authorizes? obj
		if self.authorizable_type == "User"
			self.authorizable == obj
		elsif self.authorizable_type == "Group"
			self.authorizable.users.include? obj
		else
			nil
		end
	end

	def users
		if self.authorizable_type == "User"
			[self.authorizable]
		elsif self.authorizable_type == "Group"
			self.authorizable.users
		else
			nil
		end
	end
end
