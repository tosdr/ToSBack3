class VersionsController < ApplicationController
  before_filter :get_policy
  
  def index
    @versions = @policy.versions.paginate(page: params[:page])
  end

  def show
    @version = @policy.versions.find(params[:id])
  end
  
  private
  
  def get_policy
    @policy = Policy.find(params[:policy_id])
end
