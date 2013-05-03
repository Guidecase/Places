require_relative 'test_helper'

class PlaceTest < MiniTest::Unit::TestCase
  def setup
    @place = Place.new
  end
  
  def test_find_by_city
    place = Place.create!(:name => 'test', :city => 'TEST')
    places = Place.find_by_city( 'test').all
    assert_equal [place], places
  end  
  
  def test_full_address
    assert_equal '', @place.full_address
    @place.address = '1'
    @place.city = '2'    
    @place.state = '3'    
    @place.postal_code = '4'
    assert_equal '1, 2, 3, 4', @place.full_address
  end
    
  def test_save_unless_exists
    place = Place.create!(:name => 'test')
    assert_nil place.save_unless_exists
    
    @place.name = 'TEST'
    assert_nil @place.save_unless_exists
    @place.name = 'unique'    
    assert @place.save_unless_exists
  end
  
  def test_set_slug
    @place.name = 'TEST 123;TE ST'
    @place.send(:set_slug)
    assert_equal 'test_123_te_st', @place.slug, "should format slug for common display characters"
    @place.save!
    
    dup = Place.new(:name => @place.name)
    dup.send(:set_slug)
    assert_equal "test_123_te_st_1", dup.slug, "should postfix counter for duplicate slugs"
  end
end