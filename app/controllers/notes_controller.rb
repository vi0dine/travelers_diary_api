# frozen_string_literal: true

class NotesController < ApplicationController
  before_action :authenticate_user!
  after_action :verify_authorized, except: :index

  def index
    @notes = policy_scope(Note).all.order(:created_at).page params[:page]

    render :index, status: :ok
  end

  def show
    @note = authorize Note.find(params[:id])

    render :show, status: :ok
  end

  def create
    @note = Note.new(**notes_params, user: @current_user)
    authorize @note

    @note.save!

    render :create, status: :created
  end

  def update
    @note = Note.find(params[:id])
    authorize @note

    @note.update(notes_params)

    render :update, status: :ok
  end

  def destroy
    @note = Note.find(params[:id])
    authorize @note

    @note.destroy!

    render :destroy, status: :ok
  end

  private

  def notes_params
    params.require(:note).permit(%i[city title content])
  end
end
