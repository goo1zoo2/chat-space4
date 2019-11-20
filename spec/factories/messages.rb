FactoryBot.define do
  factory :message do
    content {Faker::Lorem.sentence}
    image {File.open("#{Rails.root}/spec/fixtures/test.jpeg")}
    user
    group
  end
end