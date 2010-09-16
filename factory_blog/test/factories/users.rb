Factory.define :user do |f|
  f.sequence(:username)     {|n| "user#{n}"}
  f.sequence(:password_raw) {|n| "pass#{n}"}
end
