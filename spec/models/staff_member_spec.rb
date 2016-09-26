require 'rails_helper'

RSpec.describe StaffMember, type: :model do
  describe '#password=' do
    example 'Given string, hashed_password will be 60 charactors.' do
      member = StaffMember.new
      member.password = 'baukis'
      expect(member.hashed_password).to be_kind_of(String)
      expect(member.hashed_password.size).to eq(60)
    end

    example 'Given nil, hashed_password will be nil.' do
      member = StaffMember.new(hashed_password: 'x')
      member.password = nil
      expect(member.hashed_password).to be_nil
    end
  end

  describe 'normalize value' do
    example 'remove space before and after email' do
      member = create(:staff_member, email: ' test@example.com ')
      expect(member.email).to eq('test@example.com')
    end

    example 'convert em included email to en' do
      member = create(:staff_member, email: 'ｔｅｓｔ＠ｅｘａｍｐｌｅ．ｃｏｍ')
      expect(member.email).to eq('test@example.com')
    end
    
    example 'remove em space before and after email' do
      member = create(:staff_member, email: "\u{3000}test@example.com\u{3000}")
      expect(member.email).to eq('test@example.com')
    end
    
    example 'convert HIRAGANA included family_name_kana to KATAKANA' do
      member = create(:staff_member, family_name_kana: 'てすと')
      expect(member.family_name_kana).to eq('テスト')
    end

    example 'convert en KATAKANA included family_name_kana to em KATAKANA' do
      member = create(:staff_member, family_name_kana: 'ﾃｽﾄ')
      expect(member.family_name_kana).to eq('テスト')
    end
  end      

  describe 'validation' do
    example 'Email included two of @ is invalid' do
      member = build(:staff_member, email: 'test@@example.com')
      expect(member).not_to be_valid
    end

    example 'Family_name_kana including KANJI is invalid' do
      member = build(:staff_member, family_name_kana: '試験')
      expect(member).not_to be_valid
    end
    
    example 'Family_name including sign is invalid' do
      member = build(:staff_member, family_name: '#')
      expect(member).not_to be_valid
    end

    example 'Family_name_kana including Choonpu is valid' do
      member = build(:staff_member, family_name_kana: 'エリー')
      expect(member).to be_valid
    end
    
    example 'Email duplicating other emails is invalid' do
      member1 = create(:staff_member)
      member2 = build(:staff_member, email: member1.email)
      expect(member2).not_to be_valid
    end
  end
end
