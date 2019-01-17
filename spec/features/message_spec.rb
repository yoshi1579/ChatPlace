require 'rails_helper'

feature 'message' do 
  let(:group) {create(:group)}
  let(:user) {create(:user)}

  scenario 'post a message' do
    # ログイン前には投稿ボタンない
    group.users << user
    visit group_messages_path(group)
    expect(page).to have_content('Log in')

    # ログイン処理
    visit user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'Log in'

    # メッセージの投稿
    visit group_messages_path(group)
    expect(page).to have_content('Dashboard')
    expect {
      fill_in 'message_content', with: 'test comments'
      find('button[type="submit"]').click
    }.to change(Message, :count).by(1)
  end
end
