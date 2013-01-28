# == Schema Information
#
# Table name: sites
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe Site do
  it "has a valid factory" do
    FactoryGirl.create(:site).should be_valid
  end

  it "is invalid without a url" do
    FactoryGirl.build(:site, name: nil).should_not be_valid
  end
  
  it { should respond_to(:policies) }  
  it { should respond_to(:commitments) }
    
  describe "#validates uniqueness" do
    let!(:example) { FactoryGirl.create(:site) }
    let(:dup_site) { FactoryGirl.build(:site, name: example.name) }
        
    it "is invalid without a unique url" do
      dup_site.should_not be_valid
    end
    
    it "is invalid if url isn't unique (case insensitive)" do
      dup_site.name.upcase!
      dup_site.should_not be_valid
    end
  end #validates uniqueness  
end
