RSpec.describe NotesController, type: :controller do
  let(:user) { create(:user) }
  let(:note) { create(:note, user: user) }

  before { sign_in user }

  describe '#index' do
    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe '#create' do
    subject(:create_note) { post :create, params: params }

    before do
      request.headers['HTTP_ACCEPT'] = 'text/vnd.turbo-stream.html'
    end

    context 'with valid attributes' do
      let(:params) { { note: attributes_for(:note) } }

      it 'returns http_status 200' do
        create_note
        expect(response).to have_http_status(:ok)
      end

      it 'creates a new note' do
        expect { create_note }.to change(Note, :count).by(1)
      end

      it 'not renders the index template' do
        create_note
        expect(response).not_to render_template(:index)
      end

      it 'sets a success flash message' do
        create_note
        expect(flash[:notice]).to eq(t('actions.note.create.success'))
      end
    end

    context 'with invalid attributes' do
      let(:params) { { note: attributes_for(:note, message: message) } }

      context 'with short or missing message' do
        let(:message) { '1' * 2 }
        let(:error) { ["Message #{t('activerecord.errors.models.note.attributes.message.too_short', count: 3)}"] }

        it 'returns http_status 200' do
          create_note
          expect(response).to have_http_status(:ok)
        end

        it 'does not create a new note' do
          expect { create_note }.not_to change(Note, :count)
        end

        it 'not renders the index template' do
          create_note
          expect(response).not_to render_template(:index)
        end

        it 'sets a error flash message' do
          create_note
          expect(flash[:alert]).to eq(error)
        end
      end

      context 'with long message' do
        let(:message) { '1' * 1001 }
        let(:error) { ["Message #{t('activerecord.errors.models.note.attributes.message.too_long', count: 1000)}"] }

        it 'returns http_status 200' do
          create_note
          expect(response).to have_http_status(:ok)
        end

        it 'does not create a new note' do
          expect { create_note }.not_to change(Note, :count)
        end

        it 'not renders the index template' do
          create_note
          expect(response).not_to render_template(:index)
        end

        it 'sets a error flash message' do
          create_note
          expect(flash[:alert]).to eq(error)
        end
      end
    end
  end

  describe '#destroy' do
    subject(:destroy_note) { delete :destroy, params: params }

    let(:params) { { id: note.id } }

    before { request.headers['HTTP_ACCEPT'] = 'text/vnd.turbo-stream.html' }

    it 'returns http_status 200' do
      expect(response).to have_http_status(:ok)
    end

    it 'deletes the note' do
      note = create(:note, user: user)

      expect { delete :destroy, params: { id: note.id } }.to change(Note, :count).by(-1)
    end

    it 'not renders the index template' do
      expect(response).not_to render_template(:index)
    end
  end
end
