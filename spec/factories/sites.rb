FactoryGirl.define do
  factory :site do
    sequence(:name) {|n| "example#{n}.com"}
    
    factory :site_with_policies do
      # policies_count is declared as an ignored attribute and available in
      # attributes on the factory, as well as the callback via the evaluator
      ignore do
        policies_count 5
      end

      after(:create) do |site, evaluator|
        evaluator.policies_count.times { site.policies << FactoryGirl.create(:policy)}
      end
      
      # This allows us to do:
      # 
      # FactoryGirl.create(:site).policies.length # 0
      # FactoryGirl.create(:site_with_policies).policies.length # 5
      # FactoryGirl.create(:site_with_policies_with_policies, policies_count: 15).policies.length # 15
      
    end  
  end
end