FactoryBot.define do
  factory :unit do
    unit_number { (1..20).to_a.sample }
    floor_plan { Unit.floor_plans.keys.sample.to_sym }
    resident { Faker::Artist.name }
    move_in { Date.today - (1..100).to_a.sample.days }
    move_out { Date.today - (1..3).to_a.sample.years }
  end
end
