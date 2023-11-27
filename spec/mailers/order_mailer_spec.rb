require "rails_helper"

RSpec.describe OrderMailer, type: :mailer do
  include Rails.application.routes.url_helpers

  describe '.send_confirmation' do
    before(:all) do
      @order = FactoryBot.create(:order)
      @user = @order.user
      @order_mailer = OrderMailer.send_confirmation(@order)
    end

    it "does be set to be delivered to the user from the order passed in" do
      expect(@order_mailer).to deliver_to(@user.email)
    end

    it "does be set to be send from from@example.com" do
      expect(@order_mailer).to deliver_from('no-reply@example.com')
    end

    it "does containt  the user's message in the mail body" do
      expect(@order_mailer).to have_body_text(/Order: #{@order.id}/)
    end

    it "does have the correct subject" do
      expect(@order_mailer).to have_subject(/Order Confirmation/)
    end

    it "does have the products count" do
      expect(@order_mailer).to have_body_text(/You ordered #{@order.products.count} products:/)
    end
  end
end
