class Membership < ActiveRecord::Basebelongs_to :user
belongs_to :group
end
