require 'rails_helper'

RSpec.describe EventCreator do
  describe '.call' do
    it 'creates a Event' do
      task = create(:task)

      expect{ described_class.call(task.id) }.to change{ Event.count }.by(1)
    end

    it 'creates a Event with the right parameters' do
      stub_const('EventCreator::COLOURS', ['nice colour'])
      stub_const('EventCreator::PHRASES', ['nice phrase'])

      time = Time.zone.now
      allow_any_instance_of(Task).to receive(:updated_at).and_return(time)

      task = create(:task)

      event = described_class.call(task.id)

      expect(event).to have_attributes(task: task,
                                       event_type: 'task completion',
                                       completed_at: time,
                                       payload: { 'colour' => 'nice colour',
                                                  'phrase' => 'nice phrase' })
    end
  end
end
