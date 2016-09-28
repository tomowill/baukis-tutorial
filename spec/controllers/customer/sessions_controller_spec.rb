require 'rails_helper'

describe Customer::SessionsController do
  describe '#create' do
    let(:customer) { create(:customer, password: 'password') }
    example '次回から自動でログインするにチェックせずにログイン' do
      post :create, customer_login_form: {
        email: customer.email,
        password: 'password'
      }

      expect(session[:customer_id]).to eq(customer.id)
      expect(response.cookies).not_to have_key('customer.id')
    end

    example '次回から自動でログインするにチェックしてログイン' do
      post :create, customer_login_form: {
        email: customer.email,
        password: 'password',
        remember_me: '1' 
      }

      expect(session).not_to have_key(:customer_id)
      expect(response.cookies['customer_id']).to match(/[0-9a-f]{40}\z/)

      cookies = response.request.env['action_dispatch.cookies']
        .instance_variable_get(:@set_cookies)
      expect(cookies['customer_id'][:expires]).to be > 1.weeks.from_now
    end
  end
end
