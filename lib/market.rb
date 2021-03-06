class Market 
  attr_reader :name, :vendors 
  def initialize(name)
    @name = name
    @vendors = []
  end

  def add_vendor(vendor)
    @vendors << vendor 
  end

  def vendor_names 
    @vendors.map do |vendors|
      vendors.name
    end
  end

  def vendors_that_sell(item)
    @vendors.find_all do |vendor|
      vendor.inventory.include?(item) 
    end
  end

  def sorted_item_list
    @vendors.flat_map do |vendor|
      vendor.inventory.map do |item, name|
        item.name
      end
    end.sort.uniq
  end

  def item_list
    @vendors.flat_map do |vendor|
      vendor.inventory.map do |item, name|
        item
      end
    end.uniq
  end

  def total_inventory
    foods = Hash.new(0)
    item_list.each do |item|
      foods[item] = {quantity: 0, vendors: []}
      vendors_that_sell(item).each do |vendor|
        foods[item][:vendors] << vendor
        foods[item][:quantity] += vendor.check_stock(item)
      end
    end
    foods
  end

  def overstocked_items
    overstocked_items = []
    total_inventory.find_all do |item, quantity|
     if quantity[:quantity] >= 50 && vendors_that_sell(item).count > 1
      overstocked_items << item
     end
    end
    overstocked_items.flatten
  end

  def date
    Date.today.strftime("%d/%m/%Y")
  end

  def sell(item, amount)
   
  end
end