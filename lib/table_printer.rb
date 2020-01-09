module TablePrinter
  def self.print_table(table:)
    @@headers = table[0].keys
    @@items = table
    @@columns = @@headers.each_with_object({}) { |header, hash|
      hash[header] = (@@items.map {|item| item[header].to_s.length} + [header.length]).max }
    write_divider + write_header + write_divider + write_items + write_divider
  end

  private

  def self.write_header
    "| #{@@columns.map{|header, width| header.to_s.capitalize.ljust(width)}.join(' | ') } |\n"
  end

  def self.write_divider
    "+-#{@@columns.map{|header, width| "-" * width}.join("-+-") }-+\n"
  end

  def self.write_items
    @@items.map { |item| write_line(item) }.join('')
  end

  def self.write_line(item)
    "| #{@@columns.map{|header, width| item[header].to_s.ljust(width)}.join(" | ") } |\n"
  end
end
