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
end
