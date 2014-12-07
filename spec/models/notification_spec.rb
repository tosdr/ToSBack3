# == Schema Information
#
# Table name: notifications
#
#  id         :integer          not null, primary key
#  site       :string(255)
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  diff_url   :string(255)
#

require 'spec_helper'

describe Notification do
  let(:notification) { FactoryGirl.build(:notification) }

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
