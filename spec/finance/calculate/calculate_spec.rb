# $Id$

require File.join(File.dirname(__FILE__), %w[ .. .. spec_helper.rb ])

include Finance

describe Calculate do

  it "should be instansiated without parameters" do
    lambda { Calculate.new() }.should_not raise_error
    lambda { Calculate.new("foo") }.should raise_error(ArgumentError)
  end

  it "should calculate the present_value given the future amount, rate and timeframe" do
  end
end

