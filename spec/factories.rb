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

  factory :asset_list do
    sequence(:name) { |n| "Name_#{n}" }

    trait :with_band do
      band
    end
  end

  factory :asset do
    sequence(:name) { |n| "Name_#{n}" }

    trait :with_list do
      association :list, factory: :asset_list
    end
  end

  factory :asset_attachment, class: Asset::Attachment do
    file File.open(File.join(Rails.root, '/spec/fixtures/rails.png'))

    trait :with_asset do
      association :asset, factory: :asset
    end

    trait :with_band do
      band
    end
  end

  factory :task_list do
    sequence(:name) { |n| "Name_#{n}" }

    trait :with_band do
      band
    end
  end

    factory :task do
    sequence(:name) { |n| "Name_#{n}" }

    trait :with_band do
      band
    end

    trait :with_list do
      association :list, factory: :task_list
    end
  end

end