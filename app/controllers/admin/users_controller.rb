class Admin::UsersController < AdminController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to admin_users_path, notice: "#{@user.full_name} created!"
    else
      render :new
    end
  end

  def index
    @users = User.all.page(params[:page]).per(3)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_user_path(@user)
    else
      render :edit
    end
  end

  def show
    @user = User.find(params[:id])
  end

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end