class NotesController < ApplicationController
  before_action :authenticate_user!, only: %i[create destroy]

  def index
    @notes_count = Note.all.size
    @notes = Note.order(created_at: :desc).page(params[:page]).per(20)
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id

    if @note.save
      redirect_to root_path
    else
      @notes = Note.all
      render :index
    end
  end

  def destroy
    @note = Note.find(params[:id])

    if @note.user == current_user
      @note.destroy
    else
      flash[:alert] = 'Вы не можете удалить эту заметку'
    end

    redirect_to root_path
  end

  private

  def note_params
    params.require(:note).permit(:message)
  end
end
