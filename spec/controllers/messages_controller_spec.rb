require 'rails_helper'

describe MessagesController do
  let(:group) {create(:group)}
  let(:user) {create(:user)}

  describe '#index' do
    context 'when logged in' do
      before do 
        login user
        get :index, params: {group_id: group.id}  
      end

      it 'assign @group' do
        expect(assigns(:group)).to eq group
      end

      it 'assign @message' do
        expect(assigns(:message)).to be_a_new(Message)
      end

      it 'render index' do
        expect(response).to render_template :index
      end
    end

    context 'when not logged in' do
      before do 
        get :index, params: {group_id: group.id}  
      end

      it 'redirect to login page' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
