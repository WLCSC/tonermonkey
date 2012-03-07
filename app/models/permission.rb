class Permission < ActiveRecord::Basebelongs_to :principal
belongs_to :securable, :polymorphic => true
end
