require 'pry'

class FoodItem
  attr_reader :identifier, :name, :price_in_pence
  
  def initialize(identifier:, name:, price_in_pence:)
    @identifier = identifier
    @name = name
    @price_in_pence = price_in_pence
  end  
end

class PricingRule
  attr_reader :food_item, :quantity, :percentage_off

  def initialize(food_item:, quantity: nil, percentage_off: nil)
    @food_item = food_item
    @quantity = quantity
    @percentage_off = percentage_off
  end

  def rule
    {
      item_identifier: food_item_identifier, 
      name: food_item_name,
      unit_price: food_item_price,
      special_price: {
        quantity: quantity,
        percentage_off: percentage_off
      }
    }
  end

  private

  def food_item_identifier
    food_item.identifier
  end

  def food_item_name
    food_item.name
  end

  def food_item_price
    food_item.price_in_pence
  end
end

class Checkout
  attr_accessor :pricing_rules, :scan_list, :total_in_pence
  
  def initialize(pricing_rules:)
    @pricing_rules = pricing_rules
    @scan_list = []
    @total_in_pence = 0
  end

  def scan(food_item)
    scan_list.push(food_item.identifier)
  end

  def total
    calculate_total
    @total_in_pence
  end

  private

  def find_pricing_rule_for_food_item(food_item_identifier)
    pricing_rules.find {|pricing_rule| pricing_rule[:item_identifier] == food_item_identifier }
  end

  def calculate_total
    scan_list.each do |id|
      pricing_rule = find_pricing_rule_for_food_item(id)
      @total_in_pence += pricing_rule[:unit_price]
    end
  end
end

#####################################################
#####################################################

cheese = FoodItem.new(identifier: "A", name: "Cheese", price_in_pence: 200)
milk = FoodItem.new(identifier: "B", name: "Milk", price_in_pence: 100)
cheese_pricing_rule = PricingRule.new(food_item: cheese, quantity: 2, percentage_off: 10).rule
milk_pricing_rule = PricingRule.new(food_item: milk, quantity: 2, percentage_off: 10).rule
co = Checkout.new(pricing_rules: [cheese_pricing_rule, milk_pricing_rule])

#####################################################
#####################################################

co.scan(cheese)
co.scan(cheese)
co.scan(milk)
puts co.scan_list
total = co.total
puts total



# TODO: work on special pricing