require 'test_helper'

class GadgetTest < ActiveSupport::TestCase
  test "user id validation" do
  	gadget  = gadgets(:one)
  	gadget.user_id = nil
  	assert_not gadget.valid?
  end


end