class NotificationsController < ApplicationController
  def index
    @notifications = current_user.notifications.order(created_at: :desc)
  end

  def show
    @notification = Notification.find(params[:id])
  end

  def create
   @notification = find_or_create_notification

   if @notification.save
     current_user.add_notification(@notification)
     redirect_to notifications_path
   end
  end

  def destroy
    @notification = Notification.find(params[:id])
    current_user.remove_notification(@notification)

    redirect_to notifications_path
  end

  private

  def find_or_create_notification
    unless notification_exists?
      find_notification.first
    else
      Notification.new(title: params_title)
    end
  end

  def params_title
    params[:query]
  end

  def notification_exists?
    find_notification.blank?
  end

  def find_notification
    Notification.where(title: params_title, user_id: current_user)
  end
end
