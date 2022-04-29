class Checkout
  attr_reader :basket, :pricing_rules

  def initialize(pricing_rules:)
    @basket = []
    @pricing_rules = pricing_rules
  end

  def scan(item)
    if pricing_rules.keys.include?(item)
      basket.push(item)
    end
  end

  def total
    subtotal = 0
    items = basket.tally # {"A" => 2, "B" => 4}

    items.each do |item, quantity|
      if pricing_rules.fetch(item).fetch(:special, nil)
        special = pricing_rules.fetch(item).fetch(:special)
        quantity, price = special.split(" for ").map(&:to_i)
        # apply the special price to the relevant quantity
        # apply unit price to the rest
        # consider multiple quantities of the special eg. 3 for 130, add 6 to the basket
        subtotal += price
      else
        subtotal += pricing_rules.fetch(item).fetch(:unit) * quantity
      end
    end

    subtotal
  end
end