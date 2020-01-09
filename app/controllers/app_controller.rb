require 'twilio-ruby'
require 'sinatra/base'
require 'takeaway'
require 'sms_sender'
require 'table_printer'

class TakeawayApp < Sinatra::Base
  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')
  set :views, Proc.new { File.join(root, "views") }
  set :public_folder, Proc.new { File.join(root, "../public") }

  # enable sessions for orders
  enable :sessions

  get '/order-food' do
    session[:takeaway] = Takeaway.new(printer_module: TablePrinter, sms_app: Sms.new(Twilio::REST::Client, ENV["TWILIO_TEST_ID"], ENV["TWILIO_TEST_TOKEN"], ENV["TWILIO_TEST_NUM"]), menu: [{name: 'pepperoni_pizza', category: 'Pizza', price: 12.99},
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
      {name: 'red_wine', category: 'Drink', price: 7.99}])
    erb :order_page
  end
end
