# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Notes', type: :request do
  describe 'GET /notes' do
    context 'when the user is logged in' do
      let(:user) { create(:user) }
      let(:user_notes) { create_list(:note, 15, user: user) }
      before do
        get '/notes', params: {}, headers: auth_as(user)
      end

      it 'return the list of notes' do
        expect(json['notes']).to all(have_key('id'))
        expect(json['notes']).to all(have_key('title'))
        expect(json['notes']).to all(have_key('city'))
        expect(json['notes']).to all(have_key('content'))
        expect(json['notes']).to all(have_key('created_at'))
        expect(json['notes'].count).to be <= Kaminari.config.default_per_page
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'paginates results' do
        expect(json['pagination']).to have_key('current')
        expect(json['pagination']).to have_key('previous')
        expect(json['pagination']).to have_key('next')
        expect(json['pagination']).to have_key('limit')
        expect(json['pagination']).to have_key('total_pages')
        expect(json['pagination']).to have_key('total_count')
        expect(json['pagination']['total_count']).to eq(Note.where(user_id: user.id).count)
      end
    end

    context 'when the user (:admin) is logged in' do
      let(:admin) { create(:user, :admin) }
      before { get '/notes', headers: auth_as(admin) }

      it 'return the list of notes' do
        expect(json['notes']).to all(have_key('id'))
        expect(json['notes']).to all(have_key('title'))
        expect(json['notes']).to all(have_key('city'))
        expect(json['notes']).to all(have_key('content'))
        expect(json['notes']).to all(have_key('created_at'))
        expect(json['notes'].count).to be <= Kaminari.config.default_per_page
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user is a quest' do
      before { get '/notes' }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end

  describe 'GET /notes/:id' do
    context 'when the user (:user) is logged in and accessing his note' do
      let(:user) { create(:user) }
      let(:user_note) { create(:note, user: user) }
      before { get "/notes/#{user_note.id}", headers: auth_as(user) }

      it 'returns the details of the note' do
        expect(json.dig('note', 'id')).to eq(user_note.id)
        expect(json.dig('note', 'title')).to eq(user_note.title)
        expect(json.dig('note', 'content')).to eq(user_note.content)
        expect(json.dig('note', 'city')).to eq(user_note.city)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user (:user) is logged in and trying to access other users note' do
      let(:user) { create(:user) }
      let(:private_note) { create(:note) }
      before { get "/notes/#{private_note.id}", headers: auth_as(user) }

      it 'returns the error message' do
        expect(json['message']).to eq('Not allowed to show? this note')
      end

      it 'returns status code 403' do
        expect(response).to have_http_status(403)
      end
    end

    context 'when the user (:admin) is logged in and accessing his note' do
      let(:admin) { create(:user, :admin) }
      let(:admin_note) { create(:note, user: admin) }
      before { get "/notes/#{admin_note.id}", headers: auth_as(admin) }

      it 'returns the details of the note' do
        expect(json.dig('note', 'id')).to eq(admin_note.id)
        expect(json.dig('note', 'title')).to eq(admin_note.title)
        expect(json.dig('note', 'content')).to eq(admin_note.content)
        expect(json.dig('note', 'city')).to eq(admin_note.city)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user (:admin) is logged in and accessing other users note' do
      let(:admin) { create(:user, :admin) }
      let(:public_note) { create(:note) }
      before { get "/notes/#{public_note.id}", headers: auth_as(admin) }

      it 'returns the details of the note' do
        expect(json.dig('note', 'id')).to eq(public_note.id)
        expect(json.dig('note', 'title')).to eq(public_note.title)
        expect(json.dig('note', 'content')).to eq(public_note.content)
        expect(json.dig('note', 'city')).to eq(public_note.city)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the user is a quest' do
      let(:note) { create(:note) }
      before { get "/notes/#{note.id}" }

      it 'returns status code 401' do
        expect(response).to have_http_status(401)
      end
    end
  end
end
