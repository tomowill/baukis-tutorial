class Admin::Base < ApplicationController
  before_action :authorize
  before_action :check_account
  before_action :check_timeout

  helper_method :current_administrator

  private
  def current_administrator
    if session[:administrator_id]
      @current_administrator ||=
        Administrators.find_by(id: session[:administrator_id])
    end
  end

  def authorize
    unless current_administrator
      flash.alert = 'You need to login as an administrator.'
      redirect_to :admin_login
    end
  end

  def check_account
    if current_administrator && !current_administrator.active?
      session.delete(:administrator_id)
      flash.alert = 'Your account was invalid.'
      redirect_to :admin_root
    end
  end

  TIMEOUT = 60.minutes

  def check_timeout
    if current_administrator
      if session[:last_access_time] >= TIMEOUT.ago
        session[:last_access_time] = Time.current
      else
        session.delete(:administrator_id)
        flash.alert = 'Your session has been timed out.'
        redirect_to :admin_login
      end
    end
  end
end
