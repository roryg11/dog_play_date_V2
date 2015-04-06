class RegistrationController < ApplicationController
  require 'rest-client'
  require 'json'
  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      response = RestClient.get "https://maps.googleapis.com/maps/api/geocode/json?address=" + @user.zipcode.to_s + "&key=" + ENV['GOOGLE_API_KEY']
      json = JSON.parse(response)
      @user.latitude = json["results"][0]["geometry"]["location"]["lat"]
      @user.longitude = json["results"][0]["geometry"]["location"]["lng"]
      @user.save
      filter = @user.filters.new({type: "Zipcode", content: @user.zipcode.to_s})
      filter.save
      redirect_to new_dog_path
    else
      render :new
      flash[:alert]= "User could not be signed up"
    end
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
