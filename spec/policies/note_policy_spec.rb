# frozen_string_literal: true

require 'rails_helper'

describe NotePolicy do
  subject { described_class }
  context 'user is logged in as a regular user' do
    before(:each) do
      @current_user = create(:user)
    end

    permissions :show? do
      it 'grants access if note belongs to user' do
        expect(subject).to permit(@current_user, Note.new(user: @current_user))
      end
    end

    permissions :update? do
      it 'grants access if user is logged in' do
        expect(subject).to permit(@current_user, Note.new(user: @current_user))
      end
    end

    permissions :create? do
      it 'grants access if user is logged in' do
        expect(subject).to permit(@current_user, Note.new(user: @current_user))
      end
    end

    permissions :destroy? do
      it 'grants access if note belongs to user' do
        expect(subject).to permit(@current_user, Note.new(user: @current_user))
      end
    end
  end

  context 'user is an admin' do
    before(:each) do
      @current_user = create(:user, :admin)
    end

    permissions :index? do
      it 'grants access' do
        expect(subject).to permit(@current_user, Note.new)
      end
    end

    permissions :show? do
      it 'grants access' do
        expect(subject).to permit(@current_user, Note.new)
      end
    end

    permissions :create? do
      it 'grants access to create note' do
        expect(subject).to permit(@current_user, Note.new)
      end
    end

    permissions :destroy? do
      it 'grants access to destroy note' do
        expect(subject).to permit(@current_user, Note.new)
      end
    end
  end

  context 'user is a quest' do
    before(:each) do
      @current_user = nil
    end

    permissions :index? do
      it 'denies access to note' do
        expect(subject).to_not permit(@current_user, Note.new)
      end
    end

    permissions :show? do
      it 'denies access to note' do
        expect(subject).to_not permit(@current_user, Note.new)
      end
    end

    permissions :create? do
      it 'denies access to create note' do
        expect(subject).to_not permit(@current_user, Note.new)
      end
    end

    permissions :destroy? do
      it 'denies access to destroy note' do
        expect(subject).to_not permit(@current_user, Note.new)
      end
    end
  end
end
