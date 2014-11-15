class Picture < ActiveRecord::Base

  belongs_to :gadget

  has_attached_file :image,
    :path => ":rails_root/public/images/:id/:filename",
    :url  => "/images/:id/:filename"

  do_not_validate_attachment_file_type :image
  validates_presence_of :gadget_id
end
