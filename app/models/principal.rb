class Principal < ActiveRecord::Basehas_many :permissions
belongs_to :authorizable, :polymorphic => :true
end
