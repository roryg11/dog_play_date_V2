require 'pry'
class DogsController < ApplicationController
  before_action :authenticate_user, only: [:new, :create, :destroy, :edit]
  def index
    @dogs=Dog.all
  end

  def new
    @dog = current_user.dogs.new
  end

  def index
    @dogs = Dog.all
    if current_user
      zip_filter = current_user.filters.where(:type=> "Zipcode")[0]
      @dogs = zip_filter.filter(@dogs)
      @dogs = @dogs.where.not(user_id: current_user.id)
    end
    if !params[:g].blank?
      puts "filtering by gender"
      @dogs = @dogs.where(:gender=> params[:g])
    end
    if !params[:n].blank?
      dog_name = params[:n].downcase
      @dogs = @dogs.where("LOWER (name) LIKE ?", "%#{dog_name}%")
    end
    if !params[:s].blank?
      dog_size = params[:s].downcase
      @dogs = @dogs.where("LOWER (size) LIKE ?", "%#{dog_size}%")
    end
    if !params[:p].blank?
      dog_personality = params[:p].downcase
      @dogs = @dogs.where("LOWER (personality) LIKE ?", "%#{dog_personality}%")
    end
    if !params[:y].blank?
      dog_play = params[:y].downcase
      @dogs = @dogs.where("LOWER (play) LIKE ?", "%#{dog_play}%")
    end
    if !params[:a].blank?
      dog_age = params[:a].downcase
      @dogs = @dogs.where("LOWER (age) LIKE ?", "%#{dog_age}%")
    end
  end

  def create
    @dog = current_user.dogs.new(dog_params)
    @dog.zipcode = current_user.zipcode
    if @dog.save
      redirect_to preferences_path
    else
      render :new
    end
  end

  def edit
    @dog = Dog.find(params[:id])
  end

  def update
    @dog = Dog.find(params[:id])
    @dog.update(dog_params)
    if @dog.save
      redirect_to profile_path
    else
      render :edit
      flash[:notice] = "Dog could not be updated"
    end
  end

  def destroy
    @dog=Dog.find(params[:id])
    @dog.destroy
    redirect_to profile_path
    flash[:notice] = "Dog successfully removed from your family"
  end

  def show
    @dog = Dog.find(params[:id])
    render json: @dog
  end

  private
    def dog_params
      params.require(:dog).permit(
      :name,
      :breed,
      :gender,
      :age,
      :size,
      :play,
      :personality,
      :bio,
      :avatar,
      :user_id,
      :zipcode)
    end
end
