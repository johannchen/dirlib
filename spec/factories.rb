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

  factory :message do
    mdate "2011-01-01"
    title "message"
    speaker "foo lee"
    verses "John 3:16, Matthew 6:19-21"
    summary "what a message!"
    application "do the right thing"
    url "http://www.gracedimension.com"
  end
end
