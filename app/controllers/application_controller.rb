class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def admin_user_required
    @current_user = User.find_by_id(session[:user_id])
    flash[:notice] = nil
    unless @current_user and @current_user.role <= User::ADMIN_USER
      flash[:notice] = "please login"
      redirect_to :controller => :account, :action => :login
    end
  end

  def super_user_required
    @current_user = User.find_by_id(session[:user_id])
    flash[:notice] = nil
    unless @current_user and @current_user.role == User::SUPER_USER
      flash[:notice] = 'please login as super user'
      redirect_to :controller => :account, :action => :login
    end
  end
end
