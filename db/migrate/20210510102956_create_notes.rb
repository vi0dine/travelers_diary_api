# frozen_string_literal: true

class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string :city, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.belongs_to :user
      t.timestamps
    end
  end
end
