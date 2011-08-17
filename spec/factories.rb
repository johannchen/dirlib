FactoryGirl.define do
  sequence :email do |n|
    "foo#{n}@example.com"
  end

  factory :user do 
    email
    first_name "Johann"
    last_name "Chen"
    password "secret"
    
    factory :admin do
      admin true
    end
  end

  factory :contact do
    first_name "Johann"
    last_name "Chen"
    email
    user
  end
end
