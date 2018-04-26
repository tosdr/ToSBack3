class SitesController < ApplicationController
  def index
    @sites = Site.reviewed.paginate(:page => params[:page])
  end
  
  def show
    @site = Site.includes(:policies).find(params[:id])
  end
end
