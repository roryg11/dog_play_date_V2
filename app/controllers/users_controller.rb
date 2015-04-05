class UsersController < ApplicationController
  require 'rest-client'
  require 'json'
  def profile
    user = current_user
    @conversations = user.conversations_user_can_see
    @dogs = Dog.where.not(user_id: user.id)
    @filters = user.filters
    @filters.each do |filter|
      @dogs = filter.filter(@dogs)
    end
    @dogs = @dogs.shuffle
    @users_dogs = current_user.dogs

  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to profile_path
      flash[:notice] = "Profile successfully updated"
    else
      render :edit
    end
    response = RestClient.get "https://maps.googleapis.com/maps/api/geocode/json?address=" + @user.zipcode.to_s + "&key=" + ENV['GOOGLE_API_KEY']
      json = JSON.parse(response)
      @user.latitude = json["results"][0]["geometry"]["location"]["lat"]
      @user.longitude = json["results"][0]["geometry"]["location"]["lng"]
      @user.save
  end

  def show
    @user = User.find(params[:id])
    @dogs = @user.dogs
  end

  private
  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :zipcode,
      :age,
      :bio,
      :gender,
      :avatar,
      :password,
      :password_confirmation
    )
  end
end
