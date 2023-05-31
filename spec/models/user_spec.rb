RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  describe '#validations' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
    it { is_expected.to validate_presence_of(:password) }
  end

  describe '#authenticatable' do
    it 'authenticates with correct password' do
      expect(user.valid_password?('password')).to be true
    end

    it 'does not authenticate with incorrect password' do
      expect(user.valid_password?('incorrect')).to be false
    end
  end

  describe '#registerable' do
    let(:user) { build(:user) }

    it 'registers a new user' do
      expect { user.save }.to change(described_class, :count).by(1)
    end
  end

  describe '#rememberable' do
    it 'remembers user' do
      expect(user.remember_created_at).to be_nil
      user.remember_me!
      expect(user.remember_created_at).not_to be_nil
    end

    it 'forgets user' do
      user.remember_me!
      expect(user.remember_created_at).not_to be_nil
      user.forget_me!
      expect(user.remember_created_at).to be_nil
    end
  end

  describe '#validatable' do
    let(:user) do
      build(:user, email: email, password: password, password_confirmation: password_confirmation)
    end

    let(:email) { 'test@example.com' }
    let(:password) { 'password' }
    let(:password_confirmation) { 'password' }

    context 'with valid attributes' do
      it 'is valid' do
        expect(user).to be_valid
      end
    end

    context 'with invalid email' do
      let(:email) { 'invalid' }

      it 'is not valid' do
        expect(user).not_to be_valid
        expect(user.errors[:email]).to include(t('activerecord.errors.models.user.attributes.email.invalid'))
      end
    end

    context 'with too short password' do
      let(:password) { 'short' }

      it 'is short' do
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include(t('activerecord.errors.models.user.attributes.password.too_short', count: 6))
      end
    end

    context 'with too long password' do
      let(:password) { '1' * 251 }

      it 'is long' do
        expect(user).not_to be_valid
        expect(user.errors[:password]).to include(t('activerecord.errors.models.user.attributes.password.too_long', count: 128))
      end
    end
  end
end
