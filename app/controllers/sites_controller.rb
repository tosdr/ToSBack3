class SitesController < ApplicationController
  def index
    @sites = Site.reviewed.paginate(:page => params[:page], count: {group: 'site_id'})
  end
  
  def show
    @site = Site.find(params[:id])
  end
end
