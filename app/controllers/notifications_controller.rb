class NotificationsController < ApplicationController
  def index
    @notifications = Notification.paginate(:page => params[:page])
  end
end
