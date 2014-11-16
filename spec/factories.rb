FactoryGirl.define do

  factory :user do
    sequence(:email) { |n| "email_#{n}@example.com" }
    password 'password123'

    trait :with_bands do
      after(:create) do |user|
        user.bands << create(:band, name: "Name")
      end
    end
  end

  factory :band do
    sequence(:name) { |n| "Name_#{n}" }
  end

end