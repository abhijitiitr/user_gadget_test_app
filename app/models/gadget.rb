class Gadget < ActiveRecord::Base

  has_many :pictures, :dependent => :destroy
  belongs_to :user
  validates_presence_of :user_id
end
