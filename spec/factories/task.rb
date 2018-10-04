FactoryBot.define do
  factory :task do
    user
    title { 'task title' }
  end
end
