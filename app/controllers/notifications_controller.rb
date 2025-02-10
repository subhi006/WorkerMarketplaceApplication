class NotificationsController < ApplicationController
  def index
    @notifications =  Notification.in_order_of(:status, [ "unread", "read" ])
  end

  def show
    @notification = Notification.find(params[:id])
  end

  def unread
    @notifications = Notification.unread
  end

  def mark_as_read
    @notification = Notification.find(params[:id])
    @notification.update(status: "read")
    render :show
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)
  end
end
