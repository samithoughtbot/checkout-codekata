require 'pry'
class Checkout
  def initialize(pricing_rules)
    @total = 0
    @pricing_rules = pricing_rules
    @item_list = []
  end

  def scan(item_id)
    item = Item.new(item_id, @pricing_rules)
    @item_list.push(item_id)

    if @pricing_rules[item_id][:special_pricing]
      has_a_reduction = @item_list.count(item_id) % @pricing_rules[item_id][:special_pricing][:quantity] === 0
    end

    @total += item.give_me_your_price(has_a_reduction)
  end

  def total
    @total
  end
end

class Item
  attr_reader :pricing_rules

  def initialize(item_id, pricing_rules)
    @item_id = item_id
    @pricing_rules = pricing_rules
  end
  
  def price_and_reduction
    [pricing_rules[@item_id].fetch(:price) || 0, pricing_rules[@item_id].fetch(:reduction) || 0]
  end

  def has_special_pricing?
    pricing_rules[@item_id][:quantity]
  end

  def give_me_your_price(has_a_reduction)
    price, reduction = price_and_reduction
    if has_special_pricing? && has_a_reduction
      price - reduction
    else
      reduction = 0
      price - reduction
    end
  end
end