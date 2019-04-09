class SitesController < ApplicationController
  def index
    @sites = if params[:search_term]
      Site.where('name LIKE ?', "%#{params[:search_term]}%").order(:name).paginate(:page => params[:page])
    else
      Site.reviewed.paginate(:page => params[:page])
    end
  end
  
  def show
    @site = Site.includes(:policies).find(params[:id])
  end
end
