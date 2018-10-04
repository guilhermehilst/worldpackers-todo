class UserMailer < ActionMailer::Base
  default from: 'notification@myapp.com'
  layout 'mailer'

  def task_completion(event_id)
    @event = Event.find(event_id)
    @task = @event.task
    @user = @task.user

    mail(to: @user.email, subject: 'Task completed')
  end
end
