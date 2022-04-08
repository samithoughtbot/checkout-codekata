require "spec_helper"

RSpec.describe Checkout do
  describe "#scan" do
    it "adds the item to the basket" do
      checkout = Checkout.new
      tomato_sku = "A"

      checkout.scan(tomato_sku)

      expect(checkout.basket).to eq [tomato_sku]
    end
  end

  describe "#total" do
    context "when there is more than 1 item" do
      it "returns the total price for all the scanned items" do
        checkout = Checkout.new
        items = {"A" => 100, "B" => 250}
        stub_const("Checkout::Items", items)
        tomato_sku = "A"
        avocado_sku = "B"

        checkout.scan(tomato_sku)
        checkout.scan(avocado_sku)
        total = checkout.total

        expect(total).to eq 350
      end
    end
  end
end