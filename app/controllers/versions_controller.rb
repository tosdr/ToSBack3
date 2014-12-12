class VersionsController < ApplicationController
  before_filter :get_policy
  respond_to :html
  respond_to :js, only: [:show]
  
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

    respond_with(@version, only: :text)
  end
  
  private
  
  def get_policy
    @policy = Policy.includes(:versions).find(params[:policy_id])
  end
end
