class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :set_albums, only: [:edit]

  def index
    @users = User.all

    respond_to do |format|
      format.html
      format.json { render json: @users.to_json(include: :albums) }
    end
  end

  def show
    @user = User.find(params[:id])
    @albums = @user.albums.includes(:photos)
  end

  def edit
    @user = User.find(params[:id])
    fetch_albums_from_api(@user.id)
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def fetch_albums_from_api(user_id)
    response = HTTParty.get("https://jsonplaceholder.typicode.com/albums?userId=#{user_id}")
    @albums = response.parsed_response
  end

  def set_albums
    @albums = @user.albums
  end

  def user_params
    params.require(:user).permit(:name, :username, :email, :street, :suite, :city, :zipcode, :phone, :website)
  end
end
