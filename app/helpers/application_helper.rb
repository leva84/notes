module ApplicationHelper
  # buttons
  #
  def sign_up_button
    link_to t('buttons.sign_up'), new_user_registration_path, class: 'text-white btn btn-secondary btn-sm'
  end

  def sign_in_button
    button_to t('buttons.sign_in'), new_user_session_path, class: 'text-white btn btn-secondary btn-sm'
  end

  def sign_out_button
    button_to t('buttons.sign_out'), destroy_user_session_path, method: :delete, class: 'text-white btn btn-secondary btn-sm'
  end

  def edit_user_button(user)
    link_to user.email, edit_user_registration_path(user), class: 'text-white text-decoration-none'
  end

  # icons
  #
  def trash_icon(note)
    link_to tag.i(class: 'bi bi-trash'),
            note_path(note),
            title: t('titles.delete'),
            data: {
              turbo_method: :delete,
              turbo_confirm: t('titles.confirm'),
              notes_table_target: 'deleteIcon',
              user_id: note.user.id
            }
  end

  def no_trash_icon(note)
    content_tag :span,
                tag.i(class: 'bi bi-slash-circle'),
                title: t('titles.no_trash'),
                data: {
                  notes_table_target: 'noTrashIcon',
                  user_id: note.user.id
                }
  end

  # turbo
  #
  def update_flash
    turbo_stream.update 'flash', partial: 'layouts/flash'
  end

  def clean_note_form
    turbo_stream.replace 'new_note', partial: 'notes/form', locals: { note: new_note }
  end

  # sundry
  #
  def new_note
    Note.new
  end

  def row_number(index, notes)
    index + 1 + ((notes.current_page - 1) * notes.limit_value)
  end
end
