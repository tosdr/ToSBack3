class SitesController < ApplicationController
  def index
    @sites = Site.paginate(:page => params[:page])
  end
  
  def show
    @site = Site.find(params[:id])
  end
end
