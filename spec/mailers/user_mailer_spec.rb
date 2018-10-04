require 'rails_helper'

RSpec.describe UserMailer, type: :mailer do
  describe 'task_completions' do
    it 'renders the subject' do
      event = create(:event)
      mail = described_class.task_completion(event.id).deliver_now

      expect(mail.subject).to eq('Task completed')
    end

    it 'renders the receiver email' do
      user = create(:user, email: 'nice-email@email.com')
      task = create(:task, user: user)
      event = create(:event, task: task)
      mail = described_class.task_completion(event.id).deliver_now

      expect(mail.to).to eq([user.email])
    end

    it 'renders the sender email' do
      event = create(:event)
      mail = described_class.task_completion(event.id).deliver_now

      expect(mail.from).to eq(['notification@myapp.com'])
    end
  end
end
