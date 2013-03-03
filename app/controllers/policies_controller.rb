class PoliciesController < ApplicationController
  def index
    @policies = Policy.paginate(:page => params[:page])
  end
  
  def show
    @policy = Policy.find(params[:id])
    @sites = @policy.sites.paginate(page:params[:page])
  end
end
