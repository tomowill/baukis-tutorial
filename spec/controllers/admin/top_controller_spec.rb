require 'rails_helper'

describe Admin::TopController, 'after login' do
  let(:administrators) { create(:administrators) }

  before do
    session[:administrator_id] = administrators.id
    session[:last_access_time] = 1.second.ago
  end

  describe '#index' do
    example 'if be normal, display admin/top/dashboard.' do
      get :index
      expect(response).to render_template('admin/top/dashboard')
    end

    example 'Set suspended flag, force to logout.' do
      administrators.update_column(:suspended, true)
      get :index
      expect(session[:administrator_id]).to be_nil
      expect(response).to redirect_to(admin_root_url)
    end

    example 'Your session has been timed out.' do
      session[:last_access_time] =
        Admin::Base::TIMEOUT.ago.advance(seconds: -1)
      get :index
      expect(session[:administrator_id]).to be_nil
      expect(response).to redirect_to(admin_login_url)
    end
  end
end
