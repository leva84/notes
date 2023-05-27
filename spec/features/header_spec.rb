RSpec.describe 'Header', type: :feature do
  let(:user) { create(:user) }

  it 'when user is signed in' do
    login_as(user)

    visit root_path

    expect(page).to have_content(user.email)
    expect(page).to have_button(t('buttons.sign_out'))
  end

  it 'when user is not signed in' do
    visit root_path

    expect(page).to have_link(t('buttons.sign_up'))
    expect(page).to have_button(t('buttons.sign_in'))
  end

  it 'clicking the sign up button' do
    visit root_path
    click_link t('buttons.sign_up')
    expect(page).to have_current_path(new_user_registration_path, ignore_query: true)
  end

  it 'clicking the sign in button' do
    visit root_path
    click_button t('buttons.sign_in')
    expect(page).to have_current_path(new_user_session_path, ignore_query: true)
  end

  it 'clicking the sign out button' do
    login_as(user)

    visit root_path
    click_button t('buttons.sign_out')
    expect(page).to have_current_path(root_path, ignore_query: true)
    expect(page).to have_content(t('devise.sessions.signed_out'))
  end
end
