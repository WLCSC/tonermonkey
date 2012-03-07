class Group < ActiveRecord::Basehas_many :memberships, :dependent => true
has_many :users, :through => :memberships/nhas_one :principal, :as => :authorizable
has_many :permissions, :through => :principal
end
