class VersionsController < ApplicationController
  before_action :get_policy
  
  def index
    @versions = @policy.versions.paginate(page: params[:page])
  end

  def show
    @version = @policy.versions.find(params[:id])
    @versions = @policy.versions.limit(10)
    
    #if params[:diff].nil?
      #@content = @version.display_policy.html_safe
    #elsif params[:diff] == "current"
      #@content = @version.changes_with_current
    #elsif params[:diff] == "previous"
      #@content = @version.changes_from_previous
    #end

    #respond_with(@version, only: [:text, :created_at])
  end
  
  private
  
  def get_policy
    @policy = Policy.includes(:versions,:sites).find(params[:policy_id])
    @sites = @policy.sites.paginate(page:params[:site_page], per_page: 10)
  end
end
