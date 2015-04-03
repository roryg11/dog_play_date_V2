class FiltersController < ApplicationController
  def index
    @filters = current_user.filters
    @dogs = Dog.where.not(user_id: current_user.id)
    @filters.each do |filter|
      @dogs = filter.filter(@dogs)
    end
    @dogs = @dogs.shuffle
    @filter = @filters.new
  end

  def create
    @filter = current_user.filters.new(filter_params)
    if @filter.save
      flash[:notice]= "Your Preferences have been saved"
    else
      flash[:alert]="Your preference could not be saved"
    end
    redirect_to preferences_path
  end

  def edit
    @filter = current_user.filters.find(params[:id])
  end

  def update
    @filter = current_user.filters.find(params[:id])
    if @filter.update(filter_params)
      redirect_to preferences_path
    else
      render :edit
    end
  end

  def destroy
    @filter = current_user.filters.find(params[:id])
    @filter.destroy
    redirect_to profile_path
  end

  private
  def filter_params
    params.require(:filter).permit(:type, :content)
  end
end
