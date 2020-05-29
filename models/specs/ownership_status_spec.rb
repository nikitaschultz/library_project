require('minitest/autorun')
require('minitest/reporters')
require_relative('../ownership_status')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestOwnershipStatus < MiniTest::Test
  def setup()
    @ownershipstatus1 = OwnershipStatus.new("name" => "Wishlist")
    @ownershipstatus2 = OwnershipStatus.new("name" => "Borrowed")
  end

  def test_initialize_new_ownership_status
    assert_equal("Wishlist", @ownershipstatus1.name())
    assert_equal("Borrowed", @ownershipstatus2.name())
  end
end
