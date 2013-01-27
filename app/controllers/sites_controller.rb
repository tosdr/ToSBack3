class SitesController < ApplicationController
  def index
    @sites = Site.all
  end
end
