require 'test_helper'

class LoanTest < ActiveSupport::TestCase
  fixtures :title_fee_scenario
  fixtures :loan
  
  def test_get_monthly_payment_value_for_example_one
    example_one = loan(:example_one)
    assert_equal BigDecimal.new('4434.15'), example_one.monthly_payment.round(2)
  end
  
  def test_periodic_interest_rate_for_example_one
    example_one = loan(:example_one)
    assert_equal( BigDecimal.new('0.0060417'), example_one.periodic_interest_rate.round(7) )
  end
  
  def test_example_two_monthly_payments
    example_two = loan(:example_two)
    assert_equal(BigDecimal.new('1649.17'), example_two.monthly_payment.round(2))
  end

  def test_get_apr_for_hundred_thousand_loan_thousand_closing
    loan = loan(:hundred_thousand_loan_thousand_closing)
    #TODO: Need to implement closing costs code in loan/timfoo objects
    #assert_equal(BigDecimal.new('0.070989'), loan.apr.round(6))
  end

  def test_convert_note_rate
    myloan = Loan.new
    myloan.note_rate = 0.0675
    assert_equal(BigDecimal.new("6.75"), (BigDecimal.new(myloan.note_rate_percent.to_s)).round(2))
  end

  def test_set_note_rate_percent
    myloan = Loan.new
    myloan.note_rate_percent
    myloan.note_rate_percent = 6.75
    assert_equal(BigDecimal.new("0.0675"), (BigDecimal.new(myloan.note_rate.to_s)).round(4))
    assert_equal(BigDecimal.new("6.75"), (BigDecimal.new(myloan.note_rate_percent.to_s)).round(2))
  end
end
