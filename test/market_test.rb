require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/item'
require './lib/vendor'
require './lib/market'


class MarketTest < Minitest::Test
  def setup
    @item1 = Item.new({name: 'Peach', price: "$0.75"})
    @item2 = Item.new({name: 'Tomato', price: "$0.50"})
    @item3 = Item.new({name: "Peach-Raspberry Nice Cream", price: "$5.30"})
    @item4 = Item.new({name: "Banana Nice Cream", price: "$4.25"})
    @vendor1 = Vendor.new("Rocky Mountain Fresh")
    @market = Market.new("South Pearl Street Farmers Market")
  end

  def test_it_exists_with_attributes
    assert_instance_of Market, @market

    assert_equal "South Pearl Street Farmers Market", @market.name 
    assert_equal [], @market.vendors
  end

  def test_it_can_stock_vendors
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor1.stock(@item1, 35)

    vendor1.stock(@item2, 7)

    vendor2 = Vendor.new("Ba-Nom-a-Nom")
   

    vendor2.stock(@item4, 50)

    vendor2.stock(@item3, 25)

    vendor3 = Vendor.new("Palisade Peach Shack")
    

    vendor3.stock(@item1, 65)

    @market.add_vendor(vendor1)

    @market.add_vendor(vendor2)

    @market.add_vendor(vendor3)

    expected = [vendor1, vendor2, vendor3]

    assert_equal expected, @market.vendors
  end

  def test_vendors_that_sell
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor1.stock(@item1, 35)

    vendor1.stock(@item2, 7)

    vendor2 = Vendor.new("Ba-Nom-a-Nom")
  

    vendor2.stock(@item4, 50)

    vendor2.stock(@item3, 25)

    vendor3 = Vendor.new("Palisade Peach Shack")
    

    vendor3.stock(@item1, 65)

    @market.add_vendor(vendor1)

    @market.add_vendor(vendor2)

    @market.add_vendor(vendor3)

    expected1 = [vendor1, vendor3]
    expected2 = [vendor2]

    assert_equal expected1, @market.vendors_that_sell(@item1)
    assert_equal expected2, @market.vendors_that_sell(@item4)
  end
end