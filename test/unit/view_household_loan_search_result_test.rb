require 'test_helper'

class ViewHouseholdLoanSearchResultTest < ActiveSupport::TestCase
  fixtures :view_household_loan_search_result
  def test_serialization
    v = view_household_loan_search_result(:default)
    names = ['Joe Smith', 'Clint Eastwood']
    addresses = ['Boulder, CO', 'North Pole']
    assert_equal names, v.names
    assert_equal addresses, v.addresses
    assert_instance_of Array, v.names
    assert_instance_of Array, v.addresses
  end

  def test_advanced_search_array_for_keywords_city
    v = view_household_loan_search_result(:default)
    params = {:search => {:conditions => {:street_name_keywords => "", :city_keywords => "north"}}}
    result = v.advanced_search_array_for_keywords(params, v.addresses)
    assert_equal 1, result.grep(/north/i).length, "should have north"
    assert_equal 0, result.grep(/boulder/i).length, "should not have boulder"
  end

  def test_advanced_search_array_for_empty_keywords
    v = view_household_loan_search_result(:default)
    params = {:search => {:conditions => {:street_name_keywords => "", :city_keywords => ""}}}
    result = v.advanced_search_array_for_keywords(params, v.addresses)
    assert_equal 0, result.grep(/north/i).length, "should have north"
    assert_equal 1, result.grep(/boulder/i).length, "should have boulder"
  end


  def test_advanced_search_array_for_keywords_street_name
    v = view_household_loan_search_result(:default)
    params = {:search => {:conditions => {:street_name_keywords => "north", :city_keywords => ""}}}
    result = v.advanced_search_array_for_keywords(params, v.addresses)
    assert_equal 1, result.grep(/north/i).length, "should have north"
    assert_equal 0, result.grep(/boulder/i).length, "should not have boulder"
  end

  def test_advanced_search_array_for_keywords_street_name_finds_first
    v = view_household_loan_search_result(:default)
    params = {:search => {:conditions => {:street_name_keywords => "north", :city_keywords => "BoUlDeR"}}}
    result = v.advanced_search_array_for_keywords(params, v.addresses)
    assert_equal 0, result.grep(/north/i).length, "should have north"
    assert_equal 1, result.grep(/boulder/i).length, "should have boulder"
  end


  def test_names_matching_search
    v = ViewHouseholdLoanSearchResult.new
    params = {:search => {:conditions => {:street_name_keywords => "", :city_keywords => "north"}}}
    assert_equal '', v.names_matching_search(params)
  end

  def test_advanced_search_array_for_keywords_street_name_with_empty_object
    v = ViewHouseholdLoanSearchResult.new
    params = {:search => {:conditions => {:street_name_keywords => "north", :city_keywords => ""}}}
    assert_equal '',  v.addresses_matching_search(params)
  end
  
end
