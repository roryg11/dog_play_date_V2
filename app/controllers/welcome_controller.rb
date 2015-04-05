class WelcomeController < ApplicationController

  def index
    if current_user && current_user.dogs_user_can_see.any?
      @dogs = current_user.dogs_user_can_see
    else
      @dogs = Dog.all
    end
  end

end
