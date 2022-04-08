class Checkout
  Items = {}.freeze

  attr_reader :basket

  def initialize()
    @basket = []
  end

  def scan(item)
    basket.push(item)    
  end

  def total
    basket.sum { |item| Items.fetch(item) }
  end
end