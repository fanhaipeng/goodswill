class AccountController < ApplicationController
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
end
