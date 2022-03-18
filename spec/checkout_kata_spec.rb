require "checkout_kata_tdd"

RSpec.describe "checkout" do
  context "when we don't scan any items" do
    it 'gives a total price of 0' do
      pricing_rules = pricing_rules_factory
      checkout = Checkout.new(pricing_rules)

      price = checkout.total

      expect(price).to be_zero
    end
  end

  context "when scan an A" do
    it 'gives a total price of 50' do
      pricing_rules = pricing_rules_factory
      checkout = Checkout.new(pricing_rules)
      checkout.scan("A")

      price = checkout.total

      expect(price).to eq 50
    end
  end

  context "when scan an A and B" do
    it 'gives a total price of 80' do
      pricing_rules = pricing_rules_factory
      checkout = Checkout.new(pricing_rules)
      checkout.scan("A")
      checkout.scan("B")

      price = checkout.total

      expect(price).to eq 80
    end
  end

  context "when scan C,D,B and A" do
    it 'gives a total price of 115' do
      pricing_rules = pricing_rules_factory
      checkout = Checkout.new(pricing_rules)
      checkout.scan("C")
      checkout.scan("D")
      checkout.scan("B")
      checkout.scan("A")

      price = checkout.total

      expect(price).to eq 115
    end
  end

  context "when scan two A's" do
    it 'gives a total price of 100' do
      pricing_rules = pricing_rules_factory
      checkout = Checkout.new(pricing_rules)
      checkout.scan("A")
      checkout.scan("A")

      price = checkout.total

      expect(price).to eq 100
    end
  end

  context "when scan three A's" do
    it 'gives a total price of 130' do
      pricing_rules = pricing_rules_factory
      checkout = Checkout.new(pricing_rules)
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("A")

      price = checkout.total

      expect(price).to eq 130
    end
  end

  context "when scan four A's" do
    it 'gives a total price of 180' do
      pricing_rules = pricing_rules_factory
      checkout = Checkout.new(pricing_rules)
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("A")

      price = checkout.total

      expect(price).to eq 180
    end
  end

  context "when scan five A's" do
    it 'gives a total price of 230' do
      pricing_rules = pricing_rules_factory
      checkout = Checkout.new(pricing_rules)
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("A")

      price = checkout.total

      expect(price).to eq 230
    end
  end

  context "when scan six A's" do
    it 'gives a total price of 260' do
      pricing_rules = pricing_rules_factory
      checkout = Checkout.new(pricing_rules)
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("A")

      price = checkout.total

      expect(price).to eq 260
    end
  end

  context "when scan three A's and a B" do
    it 'gives a total price of 160' do
      pricing_rules = pricing_rules_factory
      checkout = Checkout.new(pricing_rules)
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("B")

      price = checkout.total

      expect(price).to eq 160
    end
  end

  context "when scan three A's and two B's" do
    it 'gives a total price of 175' do
      pricing_rules = pricing_rules_factory
      checkout = Checkout.new(pricing_rules)
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("B")
      checkout.scan("B")

      price = checkout.total

      expect(price).to eq 175
    end
  end

  context "when scan three A's and two B's and a D in order" do
    it 'gives a total price of 190' do
      pricing_rules = pricing_rules_factory
      checkout = Checkout.new(pricing_rules)
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("A")
      checkout.scan("B")
      checkout.scan("B")
      checkout.scan("D")

      price = checkout.total

      expect(price).to eq 190
    end
  end

  context "when scan three A's and two B's and a D out of order" do
    it 'gives a total price of 190' do
      pricing_rules = pricing_rules_factory
      checkout = Checkout.new(pricing_rules)
      checkout.scan("D")
      checkout.scan("A")
      checkout.scan("B")
      checkout.scan("A")
      checkout.scan("B")
      checkout.scan("A")

      price = checkout.total

      expect(price).to eq 190
    end
  end

  def pricing_rules_factory
    {
      "A" => {
        price: 50, 
        special_pricing: {
          quantity: 3, reduction: 20
        }
      }, 
      "B" => {
        price: 30, 
        special_pricing: {
          quantity: 2, reduction: 15
        }
        }, 
      "C" => {
        price: 20
      }, 
      "D" => {
        price: 15
      }
    }
  end
end
