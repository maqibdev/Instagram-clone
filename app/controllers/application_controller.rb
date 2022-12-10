# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  rescue_from ActionController::RoutingError, with: :render_404

  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  def render_404
    redirect_to(request.referer || root_path)
  end

  def record_not_found
    flash[:alert] = 'Unable to find the records.'
    redirect_to(request.referer || root_path)
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name, :email, :password, :photo) }
    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :email, :password, :password_confirmation, :current_password, :photo, :status)
    end
  end

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_back(fallback_location: root_path)
  end
end
