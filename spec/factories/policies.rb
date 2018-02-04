# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryBot.define do
  factory :policy do
    sequence(:name) { |n| "Privacy Policy #{n}" }
    sequence(:url) { |n| "http://www.example#{n}.com/privacy" }
    sequence(:xpath) { |n| "//div[@id='content_#{n}']" }
    lang "EN"
    detail " <p>500px is founded on the principle of helping people discover new photos and photographers.
    We know that you care about how your personal information is used and shared, and we take your privacy very seriously.
    By visiting the 500px website, you are accepting the practices outlined in this policy.</p>
    <p>This Privacy Policy covers 500px's treatment of personal information that 500px gathers when you are on the 500px website and when you use 500px services.
    This policy does not apply to the practices of third parties that 500px does not own or control, or to individuals that 500px does not employ or manage.</p>
    <br> Information Collected by 500px <p>We only collect personal information that is relevant to the purpose of our website.
    This information allows us to provide you with a customized and efficient experience.
    We collect the following types of information from our 500px users:<br>
    <br>"
    needs_revision true
    
    factory :policy_with_sites_and_versions do
      ignore do
        sites_count 5
        versions_count 5
      end

      after(:create) do |policy, eval|
        eval.sites_count.times { policy.sites << FactoryBot.create(:site) }
        eval.versions_count.times do |n| 
          policy.versions << FactoryBot.create(:version, policy: policy, previous_policy: policy.detail[0..-(n+2)], created_at: (n+1).days.ago)
          
          # i.e. older the created_at date in the db, the shorter the version is. e.g. two days old = two characters sliced off.
          # appears in tests like one character is added per day
        end
      end
    end #with_sites
    
  end
end
