require 'rails_helper'

RSpec.describe User, type: :model do
  before do
    @user = FactoryBot.build(:user)
  end

  describe 'ユーザー新規登録' do
    context '新規登録できるとき' do
      it '登録には必須項目の全て入力必要' do
        expect(@user).to be_valid
      end
      it 'パスワードは6文字以上必要' do
        @user.password = '123abc'
        @user.password_confirmation = '123abc'
        expect(@user).to be_valid
      end
      it '名字は全角（漢字・ひらがな・カタカナ）での入力必要' do
        @user.last_name = '竈門'
        expect(@user).to be_valid
      end
      it '名前は全角（漢字・ひらがな・カタカナ）での入力必要' do
        @user.first_name = '炭治郎'
        expect(@user).to be_valid
      end
      it '名字のフリガナは全角（カタカナ）での入力必要' do
        @user.last_name_kana = 'カマド'
        expect(@user).to be_valid
      end
      it '名前のフリガナは全角（カタカナ）での入力必要' do
        @user.first_name_kana = 'タンジロウ'
        expect(@user).to be_valid
      end
    end

    context '新規登録できないとき' do
      it 'ニックネームが空欄だと登録できない' do
        @user.nickname = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Nickname can't be blank")
      end
      it 'メールアドレスが空欄だと登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Email can't be blank")
      end
      it 'メールアドレスに@を含まない場合は登録できない' do
        @user.email = 'hoge'
        @user.valid?
        expect(@user.errors.full_messages).to include("Email is invalid")
      end
      it 'メールアドレスが重複していると登録できない' do
        @user.save
        another_user = FactoryBot.build(:user)
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include('Email has already been taken')
      end
      it 'パスワードが空欄だと登録できない' do
        @user.password = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password can't be blank")
      end
      it 'パスワード（確認含む）が5文字以下だと登録できない' do
        @user.password = '123ab'
        @user.password_confirmation = '123ab'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password is too short (minimum is 6 characters)')
      end
      it 'パスワード（確認含む）が半角英数字でないと登録できない' do
        @user.password = '123456'
        @user.password_confirmation = '123456'
        @user.valid?
        expect(@user.errors.full_messages).to include('Password Include both letters and numbers')
      end
      it 'パスワード（確認）が空欄だと登録できない' do
        @user.password = '123abc'
        @user.password_confirmation = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
      end
      it '名字は全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.last_name = 'kamado'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名前は全角（漢字・ひらがな・カタカナ）でないと登録できない' do
        @user.first_name = 'tanjiro'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '名字のフリガナは全角（カタカナ）でないと登録できない' do
        @user.last_name_kana = 'かまど'
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名前のフリガナは全角（カタカナ）でないと登録できない' do
        @user.first_name_kana = 'たんじろう'
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '名字の全角（漢字・ひらがな・カタカナ）が空欄だと登録できない' do
        @user.last_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name is invalid')
      end
      it '名前の全角（漢字・ひらがな・カタカナ）が空欄だと登録できない' do
        @user.first_name = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('First name is invalid')
      end
      it '名字のフリガナは全角（カタカナ）が空欄だと登録できない' do
        @user.last_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('Last name kana is invalid')
      end
      it '名前のフリガナは全角（カタカナ）が空欄だと登録できない' do
        @user.first_name_kana = ''
        @user.valid?
        expect(@user.errors.full_messages).to include('First name kana is invalid')
      end
      it '生年月日が空欄だと登録できない' do
        @user.birthday = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("Birthday can't be blank")
      end
    end
  end
end