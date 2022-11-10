FactoryBot.define do
  factory :user do
    nickname { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { '1a' + Faker::Internet.unique.password(min_length: 6) }
    password_confirmation { password }
    last_name { '竈門' }
    first_name { '炭治郎' }
    last_name_kana { 'カマド' }
    first_name_kana { 'タンジロウ' }
    birthday { Faker::Date.birthday }
  end
end