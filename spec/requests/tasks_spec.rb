require 'rails_helper'

RSpec.describe "Tasks", type: :request do
  describe "GET /tasks" do
    context "when user is not logged in" do
      it "redirect to login page" do
        get tasks_path

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    it "returns https status success(200)" do
      user = create(:user)
      sign_in user

      get tasks_path
      expect(response).to have_http_status(:success)
    end


    it 'only returns tasks that belongs to logged user' do
      user = create(:user)
      another_user = create(:user,
                            name: 'another user',
                            email: 'another_user@email.com')

      task = create(:task, user: user)
      another_task = create(:task, user: another_user)


      sign_in user

      get tasks_path

      expect(assigns(:tasks)).to eq([task])
    end
  end

  describe "POST /tasks" do
    it "creates a task" do
      user = create(:user)
      sign_in user

      expect {
        post '/tasks', params: { task: { title: 'new task' } }
      }.to change{ Task.count }.by(1)
    end

    it 'redirects to task index page' do
      user = create(:user)
      sign_in user

      post '/tasks', params: { task: { title: 'new task' } }
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response.body).to include("Task was successfully created.")
    end
  end

  describe "PUT /tasks/:id" do
    it "updates a task" do
      user = create(:user)
      task = create(:task, title: 'old task', user: user)
      sign_in user

      put "/tasks/#{task.id}", params: { task: { title: 'new task' } }

      expect(task.reload.title).to eq('new task')
    end

    it 'redirects to task index page' do
      user = create(:user)
      task = create(:task, title: 'old task', user: user)
      sign_in user

      put "/tasks/#{task.id}", params: { task: { title: 'new task' } }
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response.body).to include("Task was successfully updated.")
    end
  end

  describe "DELETE /tasks/:id" do
    it "destroy a task" do
      user = create(:user)
      task = create(:task, user: user)
      sign_in user

      expect {
        delete "/tasks/#{task.id}"
      }.to change{ Task.count }.by(-1)
    end

    it 'redirects to task index page' do
      user = create(:user)
      task = create(:task, user: user)
      sign_in user

      delete "/tasks/#{task.id}"
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response.body).to include("Task was successfully destroyed.")
    end
  end

  describe "PUT /tasks/:id/complete" do
    it "update task completed to true" do
      user = create(:user)
      task = create(:task, title: 'old task', user: user, completed: false)
      sign_in user

      put "/tasks/#{task.id}/complete"

      expect(task.reload.completed).to eq(true)
    end

    it 'redirects to task index page' do
      user = create(:user)
      task = create(:task, title: 'old task', user: user)
      sign_in user

      put "/tasks/#{task.id}/complete"
      follow_redirect!

      expect(response).to render_template(:index)
      expect(response.body).to include("Task #{task.title} was successfully completed.")
    end

    it 'calls TackingEvent Worker with the right parameters' do
      user = create(:user)
      task = create(:task, user: user)
      sign_in user

      expect(TrackingEventWorker).to receive(:perform_async).with(task.id)

      put "/tasks/#{task.id}/complete"
    end
  end
end
