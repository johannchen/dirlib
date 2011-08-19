FactoryGirl.define do
  sequence :email do |n|
    "foo#{n}@example.com"
  end

  factory :user do 
    email
    first_name "foo"
    last_name "chen"
    password "secret"
    
    factory :admin do
      admin true
    end
  end

  factory :contact do
    first_name "foo"
    last_name "chen"
    email
    user
  end

  factory :category do
    name "Housing"
  end

  factory :post do
    title "post foo"
    content "post content"
    category
    user
  end

end
