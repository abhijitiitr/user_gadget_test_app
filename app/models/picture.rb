class Picture < ActiveRecord::Base

  belongs_to :gadget

  has_attached_file :image,
    :path => ":rails_root/public/images/:id/:filename",
    :styles => { :large => "100x100>" , :medium => "50x50>", :small => "20x20>", :croppable => '100x90>' },
    :url  => "/images/:id/:filename"

  do_not_validate_attachment_file_type :image
  validates_presence_of :gadget_id
  attr_accessor :crop_x,:crop_y,:crop_w,:crop_h
end
