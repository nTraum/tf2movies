class RegionsController < ApplicationController
  after_action :verify_authorized, :except => [:index, :show]

  def index
  end

  def manage
    @regions = Region.all.page params[:page]
    authorize @regions
  end

  def new
    @region = Region.new
    authorize @region
  end

  def create
    @region = Region.new(region_params)
    authorize @region
    if @region.save
      redirect_to manage_regions_path, :notice => "Region '#{@region.name}' has been created successfully!"
    else
      redirect_to new_region_path, :alert => @region.errors.full_messages.join(', ')
    end
  end

  def show
    @region = Region.friendly.find(params[:id])
    @movies = @region.movies.where(:status_cd => Movie.published)
  end

  def edit
    @region = Region.friendly.find(params[:id])
    authorize @region
  end

  def update
    @region = Region.friendly.find(params[:id])
    authorize @region

    if @region.update(region_params)
      redirect_to manage_regions_path, :notice => 'Region updated.'
    else
      redirect_to manage_regions_path, :alert => @region.errors.full_messages.join(', ')
    end
  end

  def destroy
    @region = Region.friendly.find(params[:id])
    authorize @region
    @region.destroy
    redirect_to manage_regions_path, :notice => 'Region deleted.'
  end

  private

  def region_params
    params.require(:region).permit(:name)
  end
end