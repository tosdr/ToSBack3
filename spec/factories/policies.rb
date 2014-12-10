# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :policy do
    sequence(:name) { |n| "Privacy Policy #{n}" }
    sequence(:url) { |n| "http://www.example#{n}.com/privacy" }
    lang "EN"
    needs_revision true
    ignore do
      sites_count 1
      versions_count 0
    end
    
    factory :policy_with_sites_and_versions do
      ignore do
        sites_count 5
        versions_count 5
      end
    end #with_sites

    after(:build) do |policy, eval|
      eval.sites_count.times { policy.sites << FactoryGirl.create(:site) }
      eval.versions_count.times do |n| 
        policy.versions << FactoryGirl.create(:version, policy: policy, text: "<p>Policy info!</p>" * (n + 1), created_at: (n+1).days.ago)
        
        # i.e. older the created_at date in the db, the shorter the version is. e.g. two days old = two characters sliced off.
        # appears in tests like one character is added per day
      end
    end
    
  end
end
