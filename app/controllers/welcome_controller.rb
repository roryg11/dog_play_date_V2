class WelcomeController < ApplicationController

  def index
    @dogs = Dog.all
  end

end
