require('minitest/rg')
require('minitest/autorun')
require_relative('../customer.rb')
require_relative('../drink.rb')
require_relative('../pub.rb')
require_relative('../food.rb')


class CustomerTest < MiniTest::Test

  def setup
    @customer = Customer.new("Frank", 100.00, 25)
    @customer2 = Customer.new("Bill", 0.99, 25)
    @pub = Pub.new("The Boozer", 500.00)
    @food = Food.new("Crisps", 1.00, -2)
  end

  def test_has_name
    assert_equal("Frank", @customer.name)
  end

  def test_wallet_has_funds
    assert_equal(100.00, @customer.wallet)
  end

  def test_customer_can_buy_drink
    drink = Drink.new("beer", 2.99, 5)
    @customer.buy_drink(drink, @pub)
    assert_equal(1, @customer.number_of_drinks())
  end

  def test_wallet_reduces_when_buys_a_drink
    drink = Drink.new("beer", 2.99, 5)
    @customer.buy_drink(drink, @pub)
    assert_equal(97.01, @customer.wallet)
  end

  def test_customer_can_buy_drink_from_pub

    drink = Drink.new("beer", 2.99, 5)
    @pub.add_drink(drink)
    @customer.buy_drink(@pub.drink_sold(drink), @pub)
    assert_equal(0, @pub.drink_count())
    assert_equal(1, @customer.number_of_drinks)
    assert_equal(5, @customer.drunkeness_level)
  end

  def test_customer_age
    assert_equal(25, @customer.age)
  end

  def test_customers_drunkeness_level
    assert_equal(0, @customer.drunkeness_level)
  end

  def test_customer_drunkeness_level_increases
    drink = Drink.new("beer", 2.99, 5)
    @customer.drunkeness_level_change(drink)
    assert_equal(5, @customer.drunkeness_level)
  end

  def test_too_drunk
    drink = Drink.new("Absenthe", 10, 50)
    @pub.add_drink(drink)
    @customer.buy_drink(@pub.drink_sold(drink), @pub)
    assert_equal(true, @customer.too_drunk(@pub))
  end

  def test_food_bought
    assert_equal(99.0, @customer.food_bought(@food))
  end

  def test_food_eat
    drink1 = Drink.new("beer", 2.99, 5)
    @pub.add_drink(drink1)
    @customer.buy_drink(@pub.drink_sold(drink1), @pub)
    @customer.food_bought(@food)
    @customer.food_eat(@food)
    assert_equal(3, @customer.drunkeness_level)
  end

end
