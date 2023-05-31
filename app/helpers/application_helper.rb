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
  def trash_icon
    tag.i(class: 'bi bi-trash')
  end

  def no_trash_icon
    tag.i(class: 'bi bi-slash-circle')
  end

  # turbo
  #
  def prepend_flash
    turbo_stream.update 'flash', partial: 'layouts/flash'
  end

  def update_counter
    turbo_stream.update 'counter', partial: 'notes/counter'
  end

  # sundry
  #
  def new_note
    Note.new
  end

  def row_number(index)
    index + 1 + ((@notes.current_page - 1) * @notes.limit_value)
  end
end
