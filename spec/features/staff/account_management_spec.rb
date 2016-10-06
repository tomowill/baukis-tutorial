require 'rails_helper'

feature '従業員によるアカウント管理' do
  include FeaturesSpecHelper
  let(:staff_member) { create(:staff_member) }

  before do
    switch_namespace(:staff)
    login_as_staff_member(staff_member)
    click_link 'アカウント'
    click_link '編集'
  end

  scenario '顧客が基本情報を更新する' do
    fill_in 'メールアドレス', with: 'text1@example.jp'
    click_button '確認画面へ進む'
    click_button '訂正'
    fill_in '氏名', with: '鈴木'
    click_button '確認画面へ進む'
    click_button '更新'

    staff_member.reload
    expect(staff_member.email).to eq('text1@example.jp')
    expect(staff_member.family_name).to eq('鈴木')
  end

  scenario '顧客が名前に無効な値を入力する' do
    fill_in '氏名', with: '？'
    click_button '確認画面へ進む'

    expect(page).to have_css('header span.alert')
    expect(page).to have_css('div.field_with_errors input#staff_member_family_name')
  end
end
