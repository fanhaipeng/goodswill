class AccountController < ApplicationController

  before_filter :logged_in, :only => :logout

  def login
    if request.post?
      user = User.authenticate(params[:user][:email], params[:user][:password])
      flash[:notice] = nil
      if user
        respond_to do |format|
          session[:user_id] = user.id
          format.html { redirect_to home_index_path }
        end
      else
        flash[:notice] = 'invalid email or password'
      end
    end
  end

  def logout
    session[:user_id] = nil
    respond_to do |format|
      format.html { render :action => :login }
    end
  end

  private 

  def logged_in
    flash[:notice] = nil
    unless session[:user_id]
      flash[:notice] = "please log in"
      redirect_to account_login_path
    end
  end

end
