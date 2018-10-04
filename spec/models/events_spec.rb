require 'rails_helper'

RSpec.describe Event, type: :model do

  it { should validate_presence_of(:type) }
  it { should validate_presence_of(:payload) }
  it { should belong_to(:task) }

end
