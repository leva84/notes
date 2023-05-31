module ApplicationHelper
  def sign_up_button
    link_to t('buttons.sign_up'), new_user_registration_path, class: 'text-white btn btn-secondary btn-sm'
  end

  def sign_in_button
    button_to t('buttons.sign_in'), new_user_session_path, class: 'text-white btn btn-secondary btn-sm'
  end

  def sign_out_button
    button_to t('buttons.sign_out'), destroy_user_session_path, method: :delete, class: 'text-white btn btn-secondary btn-sm'
  end

  def trash_icon
    tag.i(class: 'bi bi-trash')
  end

  def no_trash_icon
    tag.i(class: 'bi bi-slash-circle')
  end

  def new_note
    Note.new
  end

  def row_number(index)
    index + 1 + ((@notes.current_page - 1) * @notes.limit_value)
  end

  def prepend_flash
    turbo_stream.update 'flash', partial: 'layouts/flash'
  end

  def update_counter
    turbo_stream.update 'counter', partial: 'notes/counter'
  end
end
