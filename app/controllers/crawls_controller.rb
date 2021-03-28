class CrawlsController < ApplicationController
  def show
    @crawl = Crawl.find(params[:id])
  end
end