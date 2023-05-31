RSpec.feature 'User create their account', type: :feature do
  scenario 'visiting the new page', js: true do
    visit new_user_session_path
    expect(page).to have_field("user[email]")
    expect(page).to have_field("user[password]")
    expect(page).to have_button(t('buttons.sign_in'))
  end
end
