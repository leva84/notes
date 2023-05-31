RSpec.feature 'User edits their account', type: :feature do
  let(:user) { create(:user) }

  scenario 'visiting the edit page', js: true do
    login_as(user)
    visit edit_user_registration_path
    expect(page).to have_field("user[first_name]")
    expect(page).to have_field("user[last_name]")
    expect(page).to have_field("user[password]")
    expect(page).to have_field("user[password_confirmation]")
    expect(page).to have_field("user[current_password]")
    expect(page).to have_button(t('buttons.update_my_account'))
    expect(page).to have_button(t('buttons.cancel_my_account'))
  end
end
