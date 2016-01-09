class BusinessesController < ApplicationController
  before_filter :require_user, only: [:new, :create]

  def index
    @businesses = Business.all
  end

  def show
    @business = Business.find(params[:id])
  end

  def new
    @business = Business.new
  end

  def create
    @business = Business.new(business_params)
    
    if @business.save
      flash[:notice] = "You successfully added a business."
      redirect_to home_path
    else
      render :new
    end
  end

  private

  def business_params
    params.require(:business).permit(:name, :description, :image_url)
  end
end