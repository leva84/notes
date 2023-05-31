RSpec.describe Users::SessionsController, type: :controller do
  let(:user) { create(:user) }

  before { request.env['devise.mapping'] = Devise.mappings[:user] }

  describe '#create' do
    subject(:create_session) { post :create, params: params }

    context 'with valid params' do
      let(:params) do
        {
          user: {
            email: user.email,
            password: user.password
          }
        }
      end

      it 'returns http status 303' do
        create_session
        expect(response).to have_http_status(:see_other)
      end

      it 'signs in the user' do
        create_session
        expect(controller.current_user).to eq(user)
      end

      it 'redirects to the root path' do
        create_session
        expect(response).to redirect_to(root_path)
      end

      it 'sets a success flash message' do
        create_session
        expect(flash[:notice]).to eq(t('devise.sessions.signed_in'))
      end
    end

    context 'with invalid params' do
      let(:params) do
        {
          user: {
            email: '',
            password: ''
          }
        }
      end

      before { create_session }

      it 'returns http status 422' do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not sign in the user' do
        expect(controller.current_user).to be_nil
      end

      it 'renders the new template' do
        expect(response).to render_template(:new)
      end

      it 'sets a error messages' do
        expect(flash[:alert]).to eq(t('devise.failure.invalid', authentication_keys: 'Email'))
      end
    end
  end

  describe '#destroy' do
    subject(:destroy_session) { delete :destroy }

    before do
      sign_in user
      destroy_session
    end

    it 'returns http status 303' do
      expect(response).to have_http_status(:see_other)
    end

    it 'signs out the user' do
      expect(controller.current_user).to be_nil
    end

    it 'redirects to the root path' do
      expect(response).to redirect_to(root_path)
    end

    it 'sets a success flash message' do
      expect(flash[:notice]).to eq(t('devise.sessions.signed_out'))
    end
  end
end
