class NotificationsController < ApplicationController
  def index
    @notifications = Notification.paginate(:page => params[:page],per_page: 10)
  end
end
