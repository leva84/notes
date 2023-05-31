class NotesController < ApplicationController
  PER_PAGE = 5

  before_action :authenticate_user!, only: %i[create destroy]
  before_action :pagination_notes
  before_action :notes_count

  def index; end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id

    if @note.save
      flash[:notice] = t('actions.note.create.success')
    else
      flash[:alert] = @note.errors.full_messages
    end
  end

  def destroy
    @note = Note.find(params[:id])

    if @note.user == current_user
      @note.destroy
      flash[:notice] = t('actions.note.destroy.success')
    else
      flash[:alert] = t('actions.note.destroy.errors')
    end
  end

  private

  def note_params
    params.require(:note).permit(:message)
  end

  def pagination_notes
    @notes = Note.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
  end

  def notes_count
    @notes_count = Note.count
  end
end
