# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  subject { create(:user) }
  it { should validate_presence_of(:uid) }
  it { should validate_presence_of(:provider) }
  it { should validate_presence_of(:role) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email).case_insensitive.scoped_to(:provider) }

  it { should validate_presence_of(:uid) }
  it { should validate_uniqueness_of(:uid).case_insensitive }

  it { should define_enum_for(:role).with_values(%i[user admin]) }
end
