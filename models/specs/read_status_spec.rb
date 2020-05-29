require('minitest/autorun')
require('minitest/reporters')
require_relative('../read_status')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestReadStatus < MiniTest::Test
  def setup()
    @readstatus1 = ReadStatus.new({"name" => "Reading"})
    @readstatus2 = ReadStatus.new({"name" => "In progress"})
  end

  def test_initialize_new_read_status
    assert_equal("Reading", @readstatus1.name())
    assert_equal("In progress", @readstatus2.name())
  end
end
