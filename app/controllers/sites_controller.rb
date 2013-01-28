class SitesController < ApplicationController
  def index
    @sites = Site.paginate(:page => params[:page])
  end
end
