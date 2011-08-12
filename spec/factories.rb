Factory.define :user do |f|
  f.sequence(:email) { |n| "foo#{n}@example.com" }
  f.sequence(:first_name) { |n| "foo#{n}" }
  f.sequence(:last_name) { |n| "chen#{n}" }
  f.password "secret"
end
