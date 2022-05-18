# frozen_string_literal: true
class ApplicationController < ActionController::Base
  require 'securerandom'
  # autorization system
  include Pundit::Authorization
  include LocaleConcerns
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :get_module_active
  before_action :set_subscriber_cookies

  def get_module_active
    @module_active = params[:controller]
  end

  def after_sign_in_path_for(resource_or_scope)
    admin_dashboard_index_path
  end

  private

  # [TODO] move this fuctino to actions that connect with a channel
  def set_subscriber_cookies
    random_string = SecureRandom.hex
    cookies[:subscriber_token] = random_string[0..10]
  end

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore

    flash[:error] = t "#{policy_name}.#{exception.query}", scope: "pundit", default: :default
    redirect_to(request.referrer || admin_root_path)
  end


end
