require 'rails_helper'

RSpec.describe Event, type: :model do

  it { should validate_presence_of(:event_type) }
  it { should validate_presence_of(:payload) }
  it { should belong_to(:task) }

  describe "to_csv" do
    it 'returns an csv' do
      create(:event, payload: { user_email: 'user@email.com',
                                colour: 'nice-colour',
                                phrase: 'nice-phrase',
                                completed_at: 'some-date' })

      expect(Event.to_csv)
        .to eq("UserEmail,Colour,Phrase,Completed_at\nuser@email.com,nice-colour,nice-phrase,some-date\n")
    end
  end
end
