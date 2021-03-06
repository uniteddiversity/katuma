FactoryGirl.define do
  factory :group, class: BasicResources::Group do
    name 'Cabas'
  end

  factory :membership, class: BasicResources::Membership do
    role 1
  end

  factory :producer, class: BasicResources::Producer do
    name 'Producer'
    email 'producer@katuma.org'
    address 'c/ dels Productors, 12'
  end
end
