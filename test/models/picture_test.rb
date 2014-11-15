require 'test_helper'

class PictureTest < ActiveSupport::TestCase
  test "gadget id validation" do
  	picture  = pictures(:one)
  	picture.gadget_id = nil
  	assert_not user.valid?
  end

end