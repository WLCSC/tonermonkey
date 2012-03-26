class Permission < ActiveRecord::Base
	belongs_to :principal
belongs_to :securable, :polymorphic => true

	def authorizes? user
		self.principal.authorizes? user
	end
end
