require('minitest/rg')
require('minitest/autorun')
require_relative('../food.rb')

class FoodTest < MiniTest::Test

  def setup
    @food = Food.new("Crisps", 1.00, -2)
  end

  def test_food_name
    assert_equal("Crisps", @food.name())
  end

  def test_price
    assert_equal(1.00, @food.price())
  end

  def test_rejuventation_level
    assert_equal(-2, @food.rejuvenation_level())
  end


end
