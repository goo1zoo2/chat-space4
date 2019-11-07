class UsersController < ApplicationController
  def index
  end
  
  def edit

  end

  def update
    if current_user.update(user_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email) #paramsが:userというキーを持ち、params[:user]は:name及び:emailというキーを持つハッシュである
  end
end
