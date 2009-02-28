# $Id$

require 'bigdecimal'
require File.join(File.dirname(__FILE__), %w[ .. .. spec_helper.rb ])

include Finance

describe Calculate do

  setup do 
    @c = Calculate.new
  end

  it "should be instansiated without parameters" do
    lambda { Calculate.new() }.should_not raise_error
    lambda { Calculate.new("foo") }.should raise_error(ArgumentError)
  end

  it "should round a number" do
    n = BigDecimal.new("84.564")
    true && @c.round(n).should == 84.56
    true && @c.round(n+BigDecimal('0.001')).should == 84.57
    true && @c.round(n+BigDecimal('0.002')).should == 84.57

    n = BigDecimal.new("84.5664")
    true && @c.round(n, 3).should == 84.566
    true && @c.round((n+BigDecimal('0.0001')), 3).should == 84.567
    true && @c.round((n+BigDecimal('0.0002')), 3).should == 84.567
  end

  it "should commify a number with commas" do
    @c.commify(1000000.02).should == "1,000,000.02"
  end

  it "should format money with a $ and commas" do
    @c.money(1235433213.23).should == "$1,235,433,213.23"
  end

  it "should format a rate with %" do
    @c.rate(0.06375).should == "6.375%"
  end

  it "should calculate the present_value given the future amount, rate and timeframe" do
    @c.present_value(100, 0.06, 10).should == 55.84
  end

  it "should calculate the future_value given the current amount, rate and timeframe" do 
    @c.future_value(100, 0.06, 10).should == 179.08
  end

  it "should calculate Compound Annual Growth Rate given current_amount, future_amount and timeframe" do
    @c.cagr(100, 200, 10).should == BigDecimal.new("0.0717734625362931")
  end

  it "should calculate the mortgage payment given the principle amount, rate and timeframe" do
    @c.mortgage_payment(200000, 0.065, 30).should == 1264.14
  end

end

