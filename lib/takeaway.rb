class Takeaway
  RESTURANT_NAME = "TAKEAWAY à la CHRIS\n"

  def initialize(printer_module:, sms_app:, menu:)
    @printer = printer_module
    @order_history = Hash.new([])
    @sent_messages = []
    @sms = sms_app
    @menu = menu
  end

  def show_menu
    pretty_menu = @printer::print_table(table: @menu)
    how_to_order = "Please use the following comma seperated order format whether ordering directly or via text: '<item1>, <quantity>, <item2>, <quantity>, etc..., <total_price>, <long_format_phone_number>'"
    puts RESTURANT_NAME + pretty_menu + how_to_order
  end

  def place_order(order)
    raise 'Order not in correct format' if order.class != String
    raise 'Order not in correct format' unless order.match?(/(\A(\s*\w+, \d+,)+)(?= \d+\.*\d{2}*, \+44\d{10})/)
    order_items, total, client = interpret_order(order)
    check_total(order_items, total)
    send_text(client)
    @order_history[client] << [order_items, total]
  end

  private

  def interpret_order(order)
    order = order.scan(/[\w\.\s]+,[\d\.\s\+]+/).map{|item| item.split(',').map{|item| item.strip}}
    total, client = order.pop
    order.map!{|item| item = [item[0], item[1].to_f]}
    raise 'Item not on menu' unless order.all?{|item| @menu.any?{|o| o[:name] == item[0]}}
    [order, total.to_f, client]
  end

  def check_total(order_items, customer_total)
    order_total = order_items.inject(0.0){|sum, item| sum + (@menu.find{|o| o[:name] == item[0]}[:price] * item[1])}
    raise 'Order total incorrect' if customer_total != order_total
  end

  def send_text(client)
    message = "Thank you! Your order was placed and will be delivered before #{(Time.now + 2700).strftime("%H:%M")}"
    response = @sms.send(message, client)
    raise 'Number not valid' if response.kind_of?(Exception)
    @sent_messages << response
    puts 'Order recieved, you should recieve a text confirmation shortly!'
  end
end
