FactoryGirl.define do
  factory :message do
    body        { Faker::Lorem.sentence }
    image       { fixture_file_upload("spec/fixtures/img/ハリネズミ.png", 'image/png') }
    group_id    "1"
    user_id     "2"
  end
end
