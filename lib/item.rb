class Item 
  attr_reader :name

  def initialize(data)
    @name = data[:name]
    @price = data[:price]
  end

  def price 
    @price[1..-1].to_f
  end
end