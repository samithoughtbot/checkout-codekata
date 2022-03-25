require 'pry'
class Checkout
  def initialize(pricing_rules)
    @total = 0
    @pricing_rules = pricing_rules
    @item_list = []
  end

  def scan(item)
    @item_list.push(item)

    if has_special_pricing?(item) && @item_list.count(item) % @pricing_rules[item][:special_pricing][:quantity] === 0
      @total += @pricing_rules[item].fetch(:price) - @pricing_rules[item][:special_pricing][:reduction]
    else
      @total += @pricing_rules[item].fetch(:price)
    end
  end

  def total
    @total
  end

  private

  def has_special_pricing?(item)
    @pricing_rules[item][:special_pricing]
  end
end