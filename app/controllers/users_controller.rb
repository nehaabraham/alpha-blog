class UsersController < ApplicationController

  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to alphablog #{@user.username}"
      redirect_to articles_path
    else
      render 'new'
    end
  end

  def edit
    set_user
  end

  def update
    set_user
    if @user.update(user_params)
      flash[:success] = "Your information has been updated."
      redirect_to articles_path
    else
      render 'edit'
    end
  end

  def show
    set_user
    @user_articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  private

    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def set_user
      @user = User.find(params[:id])
    end

end
