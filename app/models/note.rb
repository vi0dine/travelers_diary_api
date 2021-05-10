# frozen_string_literal: true

class Note < ApplicationRecord
  belongs_to :user

  validates_presence_of :city, :title, :content
end
