require_relative 'test_helper'

class CityTest < MiniTest::Unit::TestCase
  def setup
    @city = City.create! :name => 'test city'
    @alt_city = City.create! :name => 'alt city'
  end

  def test_that_find_by_name_is_case_insensitivity
    city = City.find_by_name 'TeSt CiTy'
    assert_equal @city, city
  end

  def test_city_models_returned_from_places
    first = Place.new :city => 'first'
    second = Place.new :city => 'second'

    assert_equal [first.city, second.city], 
                 City.from_places([first,second])
  end
end