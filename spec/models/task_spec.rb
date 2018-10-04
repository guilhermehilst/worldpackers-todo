require 'rails_helper'

RSpec.describe Task, type: :model do

  it { should validate_presence_of(:title) }
  it { should belong_to(:user) }

  it 'sets completed field as false by default' do
    task = create(:task, title: 'new task')

    expect(task.completed).to eq(false)
  end
end
