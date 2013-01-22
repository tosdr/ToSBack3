# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :policy do
    name "Privacy Policy"
    url "http://www.site.com/privacy"
    xpath "//div[@id='content']"
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
  end
end
