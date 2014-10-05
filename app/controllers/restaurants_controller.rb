class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: [:show, :edit, :update, :destroy]
  include Concerns::Access

  def index
    @organization = current_user.organizations.first.name
    if params[:id].present?
      @restaurants = @tenant.restaurants.find(params[:id])
    else
      @restaurants = Restaurant.all
    end
  end

  def show
    @menus = Menu.where(:restaurant_id => @restaurant.id)
  end

  def export_menus
    @menus = Menu.where(:restaurant_id => params[:restaurant_id])
    respond_to do |format|
      format.html
      format.csv { render text: @menus.export_to_csv }
    end
  end

  def new
    @restaurant = Restaurant.new
    @organization = current_user.organizations.first.id
  end

  def edit
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.organization_id = current_user.organizations.first.id

    respond_to do |format|
      if @restaurant.save
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully created.' }
        format.json { render action: 'show', status: :created, location: @restaurant }
      else
        format.html { render action: 'new' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @restaurant.update(restaurant_params)
        format.html { redirect_to @restaurant, notice: 'Restaurant was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @restaurant.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @restaurant.destroy
    respond_to do |format|
      format.html { redirect_to restaurants_url }
      format.json { head :no_content }
    end
  end

  private

    def set_restaurant
      @restaurant = Restaurant.friendly.find(params[:id])
    end

    def restaurant_params
      params.require(:restaurant).permit(:name, :description, :organization_id,
                                         :users_attributes => [:id, :name, :email, :password, :password_confirmation, :remember_me]
)
    end
end