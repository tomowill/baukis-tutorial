shared_examples 'a protected admin controller' do
  describe '#index' do
    example 'redirect to the login form' do
      get :index
      expect(response).to redirect_to(admin_login_url)
    end
  end

  describe '#show' do
    example 'redirect to the login form' do
      get :show, id:1
      expect(response).to redirect_to(admin_login_url)
    end
  end
end

shared_examples 'a protected singular staff controller' do
  describe '#show' do
    example 'redirect to the login form' do
      get :show
      expect(response).to redirect_to(staff_login_url)
    end
  end
end
