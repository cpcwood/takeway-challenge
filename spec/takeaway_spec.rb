require 'takeaway'
require 'table_printer'

describe Takeaway do
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

  # let(:table_printer){double :table_printer, :print_table => "menu\n", :include => nil}
  let(:sms){double :sms, :send => 'SID'}
  let(:time2){double :time2, :strftime => '21:50'}
  let(:time){double :time, :+ => time2}
  subject{Takeaway.new(printer_module: TablePrinter, sms_app: sms, menu: menu)}

  describe '#show_menu' do
    it 'shows menu in pretty format using provided menu printer' do
      expect(subject).to receive(:print_table).with(hash_including(:table)).and_return("menu\n")
      allow(STDOUT).to receive(:puts).and_return(nil)
      subject.show_menu
    end
    it 'show how to order details at bottom of order and name at top' do
      allow(subject).to receive(:print_table).and_return("menu")
      expect{subject.show_menu}.to output("#{Takeaway::RESTURANT_NAME}menuPlease use the following comma seperated order format whether ordering directly or via text: '<item1>, <quantity>, <item2>, <quantity>, etc..., <total_price>, <long_format_phone_number>'\n").to_stdout
    end
  end

  describe '#place_order' do
    it 'raises error if order is not string' do
      order = Hash.new
      expect{subject.place_order(order)}.to raise_error('Order not in correct format')
    end
    it 'raises error if order is in incorrect format' do
      order = String.new
      expect{subject.place_order(order)}.to raise_error('Order not in correct format')
    end
    it 'raises error if order contains items not on the list' do
      order = 'pepperoni_pizza, 2, wedgez, 4, fanta, 2, 23, +447234213433'
      expect{subject.place_order(order)}.to raise_error('Item not on menu')
    end
    it 'accepts orders of the correct format' do
      order = 'pepperoni_pizza, 2, wedges, 4, fanta, 2, 51.92, +447234213433'
      expect{subject.place_order(order)}.to output("Order recieved, you should recieve a text confirmation shortly!\n").to_stdout
    end
    it 'raises error if order total is incorrect' do
      order = 'pepperoni_pizza, 2, wedges, 4, fanta, 2, 23, +447234213433'
      expect{subject.place_order(order)}.to raise_error('Order total incorrect')
    end
    it 'sends text message to client confirming order' do
      order = 'pepperoni_pizza, 2, wedges, 4, fanta, 2, 51.92, +447234213433'
      allow(STDOUT).to receive(:puts).and_return(nil)
      allow(Time).to receive(:now).and_return(time)
      message = "Thank you! Your order was placed and will be delivered before 21:50"
      expect(sms).to receive(:send).with(message, '+447234213433')
      subject.place_order(order)
    end
  end
end
