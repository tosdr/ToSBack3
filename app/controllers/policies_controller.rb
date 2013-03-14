class PoliciesController < ApplicationController
  def index
    @policies = Policy.paginate(:page => params[:page])
  end
  
  def show
    @policy = Policy.find(params[:id])
    @sites = @policy.sites.paginate(page:params[:site_page], per_page: 10)
    @versions = @policy.versions.paginate(page:params[:v_page], per_page: 10)
    @version = params[:diff_id].nil? ? @policy.versions.first : @policy.versions.find(params[:diff_id])
  end
end
