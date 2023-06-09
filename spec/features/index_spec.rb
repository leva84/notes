RSpec.describe 'Index notes', type: :feature do
  let(:user) { create(:user) }

  before do
    login_as(user)
    visit root_path
  end

  it 'creating a new note without reloading the page', js: true do
    notes_count = Note.count

    fill_in 'note_message', with: 'Test message'
    click_button t('buttons.create_note')

    expect(page).to have_content('Test message')
    expect(page).to have_current_path(root_path)
    expect(find('#counter div').text).to eq(t('note', count: notes_count + 1))
  end

  it 'deleting a note without reloading the page', js: true do
    note = create(:note, user: user)
    visit root_path

    notes_count = Note.count

    accept_confirm do
      find("a[href='#{note_path(note)}']").click
    end

    expect(page).not_to have_content(note.message)
    expect(page).to have_current_path(root_path)
    expect(find('#counter div').text).to eq(t('note', count: notes_count - 1))
  end

  it 'displaying a list of notes with author and date information' do
    notes = create_list(:note, 3, user: user)
    visit root_path

    notes.each do |note|
      expect(page).to have_content(note.message)
      expect(page).to have_content(note.user.email)
      expect(page).to have_content(note.created_at.strftime('%d.%m.%Y'))
    end
  end

  it 'displaying pagination for the list of notes' do
    create_list(:note, 25, user: user)
    visit root_path

    expect(page).to have_selector('.pagination')
  end

  it 'displaying the new note form only for authenticated users' do
    logout(:user)
    visit root_path

    expect(page).not_to have_selector('#new_note')
  end
end
