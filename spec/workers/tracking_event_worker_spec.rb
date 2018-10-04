require 'rails_helper'

RSpec.describe TrackingEventWorker, type: :worker do
  describe '#perform' do
    it 'calls EventCreator' do
      task = create(:task)

      expect(EventCreator).to receive(:call).with(task)

      described_class.new.perform(task)
    end
  end
end
