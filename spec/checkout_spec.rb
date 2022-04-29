require "spec_helper"

RSpec.describe Checkout do
  describe "#scan" do
    context "when an item has a price" do
      it "adds the item to the basket" do
        checkout = Checkout.new(pricing_rules: {"A" => 100})
        tomato_sku = "A"
        
        checkout.scan(tomato_sku)
        
        expect(checkout.basket).to eq [tomato_sku]
      end
    end
    
    context "when an item does not have a price" do
      it "does not add the item to the basket" do
        checkout = Checkout.new(pricing_rules: {})
        tomato_sku = "A"
        
        checkout.scan(tomato_sku)
        
        expect(checkout.basket).to eq []
      end
    end
  end

  describe "#total" do
    context "when there are no special prices" do
      it "returns the total price for all the scanned items" do
        pricing_rules = {"A" => {unit: 100}, "B" => {unit: 250}}
        checkout = Checkout.new(pricing_rules: pricing_rules)
        tomato_sku = "A"
        avocado_sku = "B"

        checkout.scan(tomato_sku)
        checkout.scan(avocado_sku)
        total = checkout.total

        expect(total).to eq 350
      end
    end

    context "when there are special prices" do
      it "returns the total price for all scanned items" do
        pricing_rules = {"A" => {unit: 100, special: "3 for 130"}}
        checkout = Checkout.new(pricing_rules: pricing_rules)
        tomato_sku = "A"

        checkout.scan(tomato_sku)
        checkout.scan(tomato_sku)
        checkout.scan(tomato_sku)
        checkout.scan(tomato_sku)
        total = checkout.total

        expect(total).to eq 230
      end
    end
  end
end