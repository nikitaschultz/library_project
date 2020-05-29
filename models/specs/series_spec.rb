require('minitest/autorun')
require('minitest/reporters')
require_relative('../Series')

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class TestSeries < MiniTest::Test
  def setup()
    @series1 = Series.new("name" => "Kingkiller Chronicles")
    @series2 = Series.new("name" => "Farseer Trilogy")
  end

  def test_initialize_new_series
    assert_equal("Kingkiller Chronicles", @series1.name())
    assert_equal("Farseer Trilogy", @series2.name())
  end
end
