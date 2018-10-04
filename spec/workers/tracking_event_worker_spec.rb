require 'rails_helper'

RSpec.describe TrackingEventWorker, type: :worker do
  describe '#perform' do
    it 'calls EventCreator' do
      task = create(:task)

      expect(EventCreator).to receive(:call).with(task.id).and_call_original

      described_class.new.perform(task.id)
    end

    it 'send an Email' do
      task = create(:task)

      expect{ described_class.new.perform(task.id) }
        .to change{ ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
