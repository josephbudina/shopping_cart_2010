class Market 
  attr_reader :name, :vendors 
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor 
  end

  def names 
    @vendors.map do |vendors|
      vendors.name
    end
  end
end