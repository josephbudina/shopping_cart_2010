require 'Minitest/autorun'
require 'Minitest/pride'
require './lib/item'
require './lib/vendor'
require './lib/market'
require 'date'
require 'mocha/minitest'


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
  
  def test_potential_revenuee 
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

    assert_equal 29.75, vendor1.potential_revenue 
    assert_equal 345.00, vendor2.potential_revenue 
    assert_equal 48.75, vendor3.potential_revenue 
  end
  
  def test_total_inventory
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor1.stock(@item1, 35)

    vendor1.stock(@item2, 7)

    vendor2 = Vendor.new("Ba-Nom-a-Nom")
  

    vendor2.stock(@item4, 50)

    vendor2.stock(@item3, 25)

    vendor3 = Vendor.new("Palisade Peach Shack")
    

    vendor3.stock(@item1, 65)
    vendor3.stock(@item3, 10)

    @market.add_vendor(vendor1)

    @market.add_vendor(vendor2)

    @market.add_vendor(vendor3)

    expected = {
      @item1 => {
        quantity: 100,
        vendors: [vendor1, vendor3]
      },
      @item2 => {
        quantity: 7,
        vendors: [vendor1]
      },
      @item4 => {
        quantity: 50,
        vendors: [vendor2]
      },
      @item3 => {
        quantity: 35,
        vendors: [vendor2, vendor3]
      },
    }

    assert_equal expected, @market.total_inventory
  end
  
  def test_sorted_item_list
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

    expected = ["Banana Nice Cream", "Peach", "Peach-Raspberry Nice Cream", "Tomato"]
    assert_equal expected, @market.sorted_item_list
  end

  def test_item_list 
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor1.stock(@item1, 35)
    
    vendor1.stock(@item2, 7)
    
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    
    
    vendor2.stock(@item4, 50)
    
    vendor2.stock(@item3, 25)
    
    vendor3 = Vendor.new("Palisade Peach Shack")
    
    
    vendor3.stock(@item1, 65)
    vendor3.stock(@item3, 10)
    
    @market.add_vendor(vendor1)
    
    @market.add_vendor(vendor2)
    
    @market.add_vendor(vendor3)

    expected = [@item1, @item2, @item4, @item3]

    assert_equal expected, @market.item_list
  end
  
  def test_overstocked_items 
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor1.stock(@item1, 35)
    
    vendor1.stock(@item2, 7)
    
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    
    
    vendor2.stock(@item4, 50)
    
    vendor2.stock(@item3, 25)
    
    vendor3 = Vendor.new("Palisade Peach Shack")
    
    
    vendor3.stock(@item1, 65)
    vendor3.stock(@item3, 10)
    
    @market.add_vendor(vendor1)
    
    @market.add_vendor(vendor2)
    
    @market.add_vendor(vendor3)

    assert_equal [@item1], @market.overstocked_items
  end

  def test_it_has_a_date
    Date.stubs(:today).returns(Date.parse("20200224"))
    assert_equal "24/02/2020", @market.date
  end

  def test_it_can_sell 
    vendor1 = Vendor.new("Rocky Mountain Fresh")
    vendor1.stock(@item1, 35)
    
    vendor1.stock(@item2, 7)
    
    vendor2 = Vendor.new("Ba-Nom-a-Nom")
    
    
    vendor2.stock(@item4, 50)
    
    vendor2.stock(@item3, 25)
    
    vendor3 = Vendor.new("Palisade Peach Shack")
    
    
    vendor3.stock(@item1, 65)
    vendor3.stock(@item3, 10)
    
    @market.add_vendor(vendor1)
    
    @market.add_vendor(vendor2)
    
    @market.add_vendor(vendor3)

    assert_equal false, @market.sell(@item1, 200)

    assert_equal false, @market.sell(@item5, 1)

    assert_equal true, @market.sell(@item4, 5)

    assert_equal 45, vendor2.check_stock(@item4)

    assert_equal true, @market.sell(@item1, 40)

    assert_equal 0, vendor1.check_stock(@item1)
    assert_equal 60, vendor3.check_stock(@item1)
  end
end