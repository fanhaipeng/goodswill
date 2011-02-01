class UsersController < ApplicationController

  before_filter :super_user_required, :only => [:index, :new, :create, :destroy]
  before_filter :admin_user_required, :only => [:show, :edit, :update]

  def index
    @users = User.all
  end

  def new
    @user = User.new(:role => User::ADMIN_USER)
  end

  def create
    @user = User.new(params[:user])
    respond_to do |format|
      if @user.save
        format.html { redirect_to user_path(@user) }
      else
        format.html { render :action => :new }
      end
    end
  end

  def edit
    if session[:user_id] != params[:id].to_i
      render "public/401.html", :status => 401
      return
    else
      @user = User.find_by_id(params[:id])
    end
  end

  def update
    if session[:user_id] != params[:id].to_i
      render "public/401.html", :status => 401 
      return
    else
      @user = User.find_by_id(params[:id])
      respond_to do |format|
        flash[:notice] = nil
        if @user.update_attributes(params[:user])
          format.html { redirect_to user_path(@user), :flash => { :notice => 'Password has been changed successfully'} }
        else
          format.html { render :action => 'edit' }
        end
      end
    end
  end

  def show
    @user = User.find_by_id(params[:id])
  end

  def destroy
    @user = User.find_by_id(params[:id])
    flash[:error] = nil
    respond_to do |format|
      begin 
        @user.destroy
      rescue 
        flash[:error] = "Fail to delete user #{@user.name}"
        format.html { render :action => :show }
      end
      format.html { redirect_to users_path }
    end
  end
end
