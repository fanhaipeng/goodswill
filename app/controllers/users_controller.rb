class UsersController < ApplicationController

  before_filter :super_user_required, :only => [:index, :new, :create, :destroy]
  before_filter :admin_user_required, :only => :show

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

  def show
    @user = User.find_by_id(params[:id])
  end

  def destroy
    @user = User.find_by_id(params[:id])
    respond_to do |format|
      @user.destroy
      format.html { redirect_to users_path }
    end
  end
end
