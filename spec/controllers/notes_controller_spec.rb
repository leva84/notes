RSpec.describe NotesController, type: :controller do
  let(:user) { create(:user) }
  let(:note) { create(:note, user: user) }

  describe 'GET #index' do
    it 'assigns @notes_count' do
      get :index
      expect(assigns(:notes_count)).to eq(Note.all.size)
    end

    it 'assigns @notes' do
      get :index
      expect(assigns(:notes)).to eq(Note.order(created_at: :desc).page(nil).per(20))
    end

    it 'assigns @note' do
      get :index
      expect(assigns(:note)).to be_a_new(Note)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'POST #create' do
    context 'when user is authenticated' do
      before { sign_in user }

      context 'with valid attributes' do
        it 'creates a new note' do
          expect do
            post :create, params: { note: attributes_for(:note) }
          end.to change(Note, :count).by(1)
        end

        it 'redirects to the root path' do
          post :create, params: { note: attributes_for(:note) }
          expect(response).to redirect_to(root_path)
        end
      end

      context 'with invalid attributes' do
        it 'does not create a new note' do
          expect do
            post :create, params: { note: attributes_for(:note, message: nil) }
          end.not_to change(Note, :count)
        end

        it 'renders the index template' do
          post :create, params: { note: attributes_for(:note, message: nil) }
          expect(response).to render_template('index')
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign in page' do
        post :create, params: { note: attributes_for(:note) }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'DELETE #destroy' do
    context 'when user is authenticated' do
      before { sign_in user }

      context 'when note belongs to current user' do
        it 'deletes the note' do
          note = create(:note, user: user)
          expect do
            delete :destroy, params: { id: note.id }
          end.to change(Note, :count).by(-1)
        end

        it 'redirects to the root path' do
          delete :destroy, params: { id: note.id }
          expect(response).to redirect_to(root_path)
        end
      end

      context 'when note does not belong to current user' do
        let(:other_user) { create(:user) }
        let(:other_note) { create(:note, user: other_user) }

        it 'does not delete the note' do
          other_note = create(:note, user: other_user)
          expect do
            delete :destroy, params: { id: other_note.id }
          end.not_to change(Note, :count)
        end

        it 'sets a flash alert message' do
          delete :destroy, params: { id: other_note.id }
          expect(flash[:alert]).to eq('Вы не можете удалить эту заметку')
        end

        it 'redirects to the root path' do
          delete :destroy, params: { id: other_note.id }
          expect(response).to redirect_to(root_path)
        end
      end
    end

    context 'when user is not authenticated' do
      it 'redirects to the sign in page' do
        delete :destroy, params: { id: note.id }
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
