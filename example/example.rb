require 'twilio-ruby'
require '../lib/takeaway.rb'
require '../lib/table_printer.rb'
require '../lib/sms_sender.rb'

menu = [{name: 'pepperoni_pizza', category: 'Pizza', price: 12.99},
  {name: 'ham_and_mushroom_pizza', category: 'Pizza', price: 12.99},
  {name: 'cheese_pizza', category: 'Pizza', price: 10.99},
  {name: 'tex_mex_pizza', category: 'Pizza', price: 15.99},
  {name: 'wedges', category: 'Side', price: 4.99},
  {name: 'chicken_strippers', category: 'Side', price: 6.99},
  {name: 'garlic_dip', category: 'Side', price: 0.99},
  {name: 'bbq_dip', category: 'Side', price: 0.99},
  {name: 'coke', category: 'Drink', price: 2.99},
  {name: 'fanta', category: 'Drink', price: 2.99},
  {name: 'white_wine', category: 'Drink', price: 7.99},
  {name: 'red_wine', category: 'Drink', price: 7.99}]


# Twilio Test ID test

example = Takeaway.new(printer_module: TablePrinter, sms_app: Sms.new(Twilio::REST::Client, ENV["TWILIO_TEST_ID"], ENV["TWILIO_TEST_TOKEN"], ENV["TWILIO_TEST_NUM"]), menu: menu)
example.show_menu
example.place_order("pepperoni_pizza, 2, wedges, 4, fanta, 2, 51.92, +15005550006")


# Real Test
# Warning - this will send a real text message if your ENV files are not set up to test credentials

# example = Takeaway.new(printer_module: TablePrinter, sms_app: Sms.new(Twilio::REST::Client, ENV["TWILIO_ID"], ENV["TWILIO_TOKEN"], ENV["TWILIO_NUM"]), menu: menu)
# example.show_menu
# example.place_order("pepperoni_pizza, 2, wedges, 4, fanta, 2, 51.92, #{ENV["MY_NUM"]}")
