require 'table_printer'

describe TablePrinter do

  include TablePrinter

  describe '#print_table' do
    it 'returns menu from given array in fancy print format' do
      menu = [{name: 'ham_and_mushroom_pizza', price: 12.99},
        {name: 'fanta', price: 2.99},
        {name: 'white_wine', price: 7.99}]
      expect(print_table(table: menu)).to eq("+------------------------+-------+\n| Name                   | Price |\n+------------------------+-------+\n| ham_and_mushroom_pizza | 12.99 |\n| fanta                  | 2.99  |\n| white_wine             | 7.99  |\n+------------------------+-------+\n")
    end
  end
end
