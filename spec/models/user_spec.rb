require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do

    it 'should create user if all the fields are valid' do
      @user = User.new(
        first_name: 'charu',
        last_name: 'zain',
        email: 'charu@gmail.com',
        password: 'acagnks9201145',
        password_confirmation: 'acagnks9201145'
      )
      expect(@user.valid?).to be(true)
    end

    it 'should not create user if the first name is blank' do
      @user = User.new(
        first_name: nil,
        last_name: 'jain',
        email: 'charu@gmail.com',
        password: 'acagnks9201145',
        password_confirmation: 'acagnks9201145'
      )
      expect(@user.valid?).to be(false)
      expect(@user.errors[:first_name]).to include("can't be blank")
    end

    it 'should not create user if the last name is blank' do
      @user = User.new(
        first_name: 'charu',
        last_name: nil,
         email: 'charu@gmail.com',
        password: 'acagnks9201145',
        password_confirmation: 'acagnks9201145'
      )
      expect(@user.valid?).to be(false)
      expect(@user.errors[:last_name]).to include("can't be blank")
    end

    it 'should not create user if the email is blank' do
      @user = User.new(
        first_name: 'charu',
        last_name: 'zain',
        email: nil,
        password: 'acagnks9201145',
        password_confirmation: 'acagnks9201145'
      )
      expect(@user.valid?).to be(false)
      expect(@user.errors[:email]).to include("can't be blank")
    end

    it 'should not create user if the password is blank' do
      @user = User.new(
        first_name: 'charu',
        last_name: 'jain',
        email: 'charl@gmail.com',
        password: nil,
        password_confirmation: 'acagnks9201145'
      )
      expect(@user.valid?).to be(false)
      expect(@user.errors[:password]).to include("can't be blank")
    end

    it 'should not create user if the password confirmation is blank' do
      @user = User.new(
        first_name: 'charu',
        last_name: 'zain',
        email: 'jzain@gmail.com',
        password: 'acagnks9201145',
        password_confirmation: nil
      )
      expect(@user.valid?).to be(false)
      expect(@user.errors[:password_confirmation]).to include("can't be blank")
    end

    it 'should not create user if the password doesn\'t match with the password confirmation' do
      @user = User.new(
        first_name: 'charu',
        last_name: 'zain',
        email: 'charu@gmail.com',
        password: 'acagnks9201145',
        password_confirmation: 'acagnks92'
      )
      expect(@user.valid?).to be(false)
      expect(@user.errors[:password_confirmation]).to include("doesn't match Password")
    end

    it 'should not create user if the email is already exist' do
      @user = User.new(
        first_name: 'charu',
        last_name: 'zain',
        email: 'jzain@gmail.com',
        password: 'acagnks9201145',
        password_confirmation: 'acagnks9201145'
      )
      @user.save!
      @user_duplicate = User.new(
        first_name: 'charu',
        last_name: 'zain',
        email: 'Jzain@GMAIL.COM',
        password: 'acagnks9201145',
        password_confirmation: 'acagnks9201145'
      )      
      expect(@user_duplicate.valid?).to be(false)
      expect(@user_duplicate.errors.full_messages).to include("Email has already been taken")
    end

    it 'should not create user if the password is less than 10 characters long' do
      @user = User.new(
        first_name: 'charu',
        last_name: 'zain',
        email: 'jzain@gmail.com',
        password: 'acagn',
        password_confirmation: 'acagn'
      )
      expect(@user.valid?).to be(false)
      expect(@user.errors.full_messages[0]).to include("Password is too short")
    end
  end

  describe '.authenticate_with_credentials' do

    it 'should show the user if they are registered and the credential password is correct' do
      @user = User.new(
        first_name: 'charu',
        last_name: 'zain',
        email: 'jzain@gmail.com',
        password: 'acagnks9201145',
        password_confirmation: 'acagnks9201145'
      )
      @user.save!
      expect(User.authenticate_with_credentials('jzain@gmail.com', 'acagnks9201145')).to be_truthy
    end

    it 'should not log the user if the credential password is incorrect' do
      @user = User.new(
        first_name: 'charu',
        last_name: 'zain',
        email: 'jzain@gmail.com',
        password: 'acagnks9201145',
        password_confirmation: 'acagnks9201145'
      )
      @user.save!
      expect(User.authenticate_with_credentials('ffrum@gmail.com', 'dfhjdsk')).to be(nil)
    end

    it 'should not log the user if the credential email is not registered' do
      expect(User.authenticate_with_credentials('random@gmail.com', 'acagnks9201145')).to be(nil)
    end

    it 'should log the user if the email includes spaces' do
      @user = User.new(
        first_name: 'charu',
        last_name: 'zain',
        email: 'charu@gmail.com',
        password: 'acagnks9201145',
        password_confirmation: 'acagnks9201145'
      )
      @user.save!
      expect(User.authenticate_with_credentials('  charu@gmail.com ', 'acagnks9201145')).to be_truthy
    end

    it 'should log the user in if the email is in different case' do
      @user = User.new(
        first_name: 'charu',
        last_name: 'zain',
        email: 'charu@gmail.com',
        password: 'acagnks9201145',
        password_confirmation: 'acagnks9201145'
      )
      @user.save!
      expect(User.authenticate_with_credentials('CHARU@GMAIL.COM', 'acagnks9201145')).to be_truthy
    end

  end

end 