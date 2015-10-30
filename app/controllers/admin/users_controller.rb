class Admin::UsersController < AdminController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params) 
    if @user.save
      redirect_to admin_users_path, notice: "User: #{@user.full_name} created!"
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

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      if @user.destroy
        # Tell the UserMailer to send a welcome email after save
        UserMailer.goodbye_email(@user).deliver
 
        format.html { redirect_to admin_users_path, notice: "User: #{@user.full_name} deleted!" }
        format.json { render json: @user, status: :deleted, location: @user }
      else
        format.html { render action: 'index' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end

  end 

  protected

  def user_params
    params.require(:user).permit(:email, :firstname, :lastname, :password, :password_confirmation, :admin)
  end

end