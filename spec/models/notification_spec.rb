require 'spec_helper'

RSpec.describe Notification, type: :model do
  let(:notification) { FactoryBot.build(:notification) }

  it "has a valid factory" do
    expect(notification).to be_valid
  end

  describe "image_from_sitename" do
    it "returns logo when asset exists" do
      notification.site = "facebook.com"
      expect(notification.image_from_sitename).to eq("logo/facebook.png")
    end

    it "returns a default logo when asset is missing" do
      notification.site = "madeupsite.com"
      expect(notification.image_from_sitename).to eq("logo/default.png")
    end
  end
end
