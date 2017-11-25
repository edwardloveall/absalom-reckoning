FactoryGirl.define do
  factory :calendar do
    title 'Demons and Denizens Campaign'
    current_date ArDate.new
  end
end
