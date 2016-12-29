FactoryGirl.define do
  factory :supplier, class: Suppliers::Supplier do
  end

  factory :orders_frequency, class: Suppliers::OrdersFrequency do
    trait :confirmation do
      frequency_type Suppliers::OrdersFrequency::FREQUENCY_TYPES[:confirmation]
    end
  end

  factory :order, class: Suppliers::Order do
    confirm_before Time.now.utc
    to_group_id do
      group = FactoryGirl.create(:group)
      group = Suppliers::Group.find(group.id)
      group.id
    end
    from_user_id do
      user = FactoryGirl.create(:user)
      user = Suppliers::User.find(user.id)
      user.id
    end
  end

  factory :order_line, class: Suppliers::OrderLine do
  end
end
