class NotesController < ApplicationController
  PER_PAGE = 5

  before_action :authenticate_user!, only: %i[create destroy]
  before_action :notes
  after_action :update_broadcast, only: %i[create destroy]

  def index
    set_notes_count
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id

    if @note.save
      update_notes_count
      flash.now[:notice] = t('actions.note.create.success')
    else
      flash.now[:alert] = @note.errors.full_messages
    end
  end

  def destroy
    @note = Note.find(params[:id])

    if @note.user == current_user
      @note.destroy
      update_notes_count
      flash.now[:notice] = t('actions.note.destroy.success')
    else
      flash.now[:alert] = t('actions.note.destroy.errors')
    end
  end

  private

  def note_params
    params.require(:note).permit(:message)
  end

  def notes
    @notes = Note.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
  end

  def update_notes_count
    @notes_count = Note.count
  end

  def update_broadcast
    BroadcastService.call(notes: @notes, notes_count: @notes_count)
  end
end
