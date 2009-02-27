#!/usr/bin/ruby -w

require File.expand_path(
    File.join(File.dirname(__FILE__), %w[.. lib finance]))
include Finance

c = Calculate.new

p = c.mortgage_payment(369000, 0.05375, 30)
puts "Mortgage Payment (369k @ 5.375% for 30yr): #{c.format(p)}"

pv = c.present_value(4000000, 0.06, 20)
puts "Present Value of 4M @ 6% for 20 yr: #{c.format(pv)}"
