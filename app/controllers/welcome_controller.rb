class WelcomeController < ApplicationController

  def index
    @dogs = Dog.all
    if current_user
      if current_user.blocked_users != []
        blocked_user_ids = current_user.blocked_users
        blocked_user_ids.each do |blocked_id|
          @dogs = @dogs.where.not(user_id: blocked_id)
        end
      end
      @dogs = @dogs.where.not(user_id: current_user.id)
    end
    @dogs
  end

end
