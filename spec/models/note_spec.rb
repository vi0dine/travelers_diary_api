# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Note, type: :model do
  subject { create(:note) }
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:title) }
  it { should validate_presence_of(:content) }

  it { should belong_to(:user) }
end
