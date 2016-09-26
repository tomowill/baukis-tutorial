class Admin::SessionsController < Admin::Base
  skip_before_action :authorize

  def new
    if current_administrator
      redirect_to :admin_root
    else
      @form = Admin::LoginForm.new
      render action: 'new'
    end
  end 

  def create
    @form = Admin::LoginForm.new(params[:admin_login_form])
    if @form.email.present?
      admin_member = Administrators.find_by(email_for_index: @form.email.downcase)
    end
    if Admin::Authenticator.new(admin_member).authenticate(@form.password) 
      if Admin::Authenticator.new(admin_member).suspendedcheck() 
        flash.now.alert = 'Your account is suspened .'
        render action: 'new'
      end
      session[:administrator_id] = admin_member.id
      session[:last_access_time] = Time.current
      flash.notice = 'You have logined.'
      redirect_to :admin_root
    else
      flash.now.alert = 'Your mailaddress or password are incorrect.'
      render action: 'new'
    end
  end

  def destroy
    session.delete(:administrator_id)
    flash.notice = 'You have logouted.'
    redirect_to :admin_root
  end
end
