RSpec.feature 'User create their session', type: :feature do
  scenario 'visiting the new page', js: true do
    visit new_user_registration_path
    expect(page).to have_field("user[password]")
    expect(page).to have_field("user[password]")
    expect(page).to have_field("user[password_confirmation]")
    expect(page).to have_button(t('buttons.sign_up'))
  end
end
