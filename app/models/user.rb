class User < ActiveRecord::Basehas_many :memberships, :dependent => true
has_many :groups, :through => :memberships
has_one :principal, :as => :authorizable
has_many :permissions, :through => :principal
end
