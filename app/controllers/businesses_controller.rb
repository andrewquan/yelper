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
    Business.create(business_params)
  end

  private

  def business_params
    params.require(:business).permit(:name, :description, :image_url)
  end
end