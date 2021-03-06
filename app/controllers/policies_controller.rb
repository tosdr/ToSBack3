class PoliciesController < ApplicationController
  def index
    @policies = Policy.paginate(:page => params[:page])
  end
  
  def show
    @policy = Policy.includes(:sites, :versions).find(params[:id])
    @policy_presenter = PolicyPresenter.new(@policy)
    @sites = @policy.sites.paginate(page:params[:site_page], per_page: 10)
    #@versions = @policy.versions.limit(10)
    # @version = params[:diff_id].nil? ? @policy.versions.first : @policy.versions.find(params[:diff_id])
  end
end
