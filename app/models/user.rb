class User < ActiveRecord::Base
  belongs_to :group 
  has_many :repos

  validates :username, uniqueness: true
end