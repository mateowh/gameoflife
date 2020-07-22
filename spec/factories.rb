FactoryBot.define do
  factory :cell do
    trait :alive do
      initialize_with { new(Cell::ALIVE) }
    end

    trait :dead do
      initialize_with { new(Cell::DEAD) }
    end
  end
end
