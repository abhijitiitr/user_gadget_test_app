require "test_helper"

class SessionRoutesTest < ActionDispatch::IntegrationTest
  def test_sessions
    assert_routing "/signin", :controller => "sessions", :action => "new"
  end
end
