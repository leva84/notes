RSpec.describe Users::RegistrationsController, type: :controller do
  before { request.env['devise.mapping'] = Devise.mappings[:user] }

  describe '#create' do
    subject(:create_user) { post :create, params: params }

    context 'with valid params' do
      let(:email) { Faker::Internet.email }
      let(:params) do
        {
          user: {
            email: email,
            password: 'password',
            password_confirmation: 'password'
          }
        }
      end

      it 'returns http status 303' do
        create_user
        expect(response).to have_http_status(:see_other)
      end

      it 'creates a new user' do
        expect { create_user }.to change(User, :count).by(1)
      end

      it 'redirects to the root path' do
        create_user
        expect(response).to redirect_to(root_path)
      end

      it 'sets a success flash message' do
        create_user
        expect(flash[:notice]).to eq(t('devise.registrations.signed_up'))
      end

      it 'creates user with first_name and last_name' do
        create_user
        expect(assigns(:user).first_name).to be_present
        expect(assigns(:user).last_name).to be_present
      end
    end

    context 'with invalid params' do
      let(:email_blank_error) { t('activerecord.errors.models.user.attributes.email.blank') }
      let(:password_blank_error) { t('activerecord.errors.models.user.attributes.password.blank') }
      let(:params) do
        {
          user: {
            email: '',
            password: '',
            password_confirmation: ''
          }
        }
      end

      it 'returns http status 422' do
        create_user
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not create a new user' do
        expect { create_user }.not_to change(User, :count)
      end

      it 'renders the new template' do
        create_user
        expect(response).to render_template(:new)
      end

      it 'sets a error messages' do
        create_user
        expect(assigns(:user).errors.full_messages).to include("Email #{email_blank_error}")
        expect(assigns(:user).errors.full_messages).to include("Password #{password_blank_error}")
      end
    end
  end

  describe '#update' do
    subject(:update_user) { put :update, params: params }

    let(:user) { create(:user) }

    before { sign_in user }

    context 'with valid params' do
      let(:first_name) { Faker::Name.first_name }
      let(:last_name) { Faker::Name.last_name }
      let(:params) do
        {
          user: {
            first_name: first_name,
            last_name: last_name,
            current_password: 'password'
          }
        }
      end

      it 'returns http status 303' do
        update_user
        expect(response).to have_http_status(:see_other)
      end

      it 'updates the user' do
        update_user
        user.reload
        expect(user.first_name).to eq(first_name)
        expect(user.last_name).to eq(last_name)
      end

      it 'redirects to the root path' do
        update_user
        expect(response).to redirect_to(root_path)
      end

      it 'sets a success flash message' do
        update_user
        expect(flash[:notice]).to eq(t('devise.registrations.updated'))
      end
    end

    context 'with invalid params' do
      let(:first_name) { '' }
      let(:last_name) { '' }
      let(:password) { '' }
      let(:params) do
        {
          user: {
            first_name: first_name,
            last_name: last_name,
            current_password: password
          }
        }
      end

      it 'returns http status 422' do
        update_user
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'does not update the user' do
        update_user
        user.reload
        expect(user.first_name).not_to eq('')
        expect(user.last_name).not_to eq('')
      end

      it 'renders the edit template' do
        update_user
        expect(response).to render_template(:edit)
      end

      context 'with long first_name' do
        let(:first_name) { '1' * 151 }
        let(:last_name) { Faker::Name.last_name }
        let(:password) { 'password' }
        let(:error) { t('activerecord.errors.models.user.attributes.first_name.too_long', count: 150) }

        it 'returns error message is long' do
          update_user
          expect(assigns(:user).errors.full_messages).to include("First name #{error}")
        end
      end

      context 'with short first_name' do
        let(:first_name) { '1' * 2 }
        let(:last_name) { Faker::Name.last_name }
        let(:password) { 'password' }
        let(:error) { t('activerecord.errors.models.user.attributes.first_name.too_short', count: 3) }

        it 'returns error message is short' do
          update_user
          expect(assigns(:user).errors.full_messages).to include("First name #{error}")
        end
      end

      context 'with long last_name' do
        let(:last_name) { '1' * 151 }
        let(:first_name) { Faker::Name.first_name }
        let(:password) { 'password' }
        let(:error) { t('activerecord.errors.models.user.attributes.last_name.too_long', count: 150) }

        it 'returns error message is long' do
          update_user
          expect(assigns(:user).errors.full_messages).to include("Last name #{error}")
        end
      end

      context 'with short last_name' do
        let(:last_name) { '1' * 2 }
        let(:first_name) { Faker::Name.first_name }
        let(:password) { 'password' }
        let(:error) { t('activerecord.errors.models.user.attributes.last_name.too_short', count: 3) }

        it 'returns error message is short' do
          update_user
          expect(assigns(:user).errors.full_messages).to include("Last name #{error}")
        end
      end

      context 'with empty password' do
        let(:first_name) { Faker::Name.first_name }
        let(:last_name) { Faker::Name.last_name }
        let(:password) { '' }
        let(:error) { t('activerecord.errors.models.user.attributes.current_password.blank') }

        it 'returns error message blank' do
          update_user
          expect(assigns(:user).errors.full_messages).to include("Current password #{error}")
        end
      end
    end
  end
end
