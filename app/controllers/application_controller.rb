class ApplicationController < ActionController::Base

  include Concerns::Url

  before_filter :enable_tenant
 
  
  protect_from_forgery 
  
  protected

  def update_needs_confirmation?(resource, previous)
    resource.respond_to?(:pending_reconfirmation?) &&
      resource.pending_reconfirmation? &&
      previous != resource.unconfirmed_email
  end

  def update_resource(resource, params)
    resource.update_with_password(params)
  end

  def build_resource(hash=nil)
    self.resource = resource_class.new_with_session(hash || {}, session)
  end

  def sign_up(resource_name, resource)
    sign_in(resource_name, resource)
  end

  private

  def after_sign_up_path_for(resource)
    users_path(resource)
  end

  def enable_tenant
    @tenant = Tenant.new(current_user)
  end

  def after_inactive_sign_up_path_for(resource)
    scope = Devise::Mapping.find_scope!(resource)
    router_name = Devise.mappings[scope].router_name
    context = router_name ? send(router_name) : self
    context.respond_to?(:root_path) ? context.root_path : "/"
  end

  def after_update_path_for(resource)
    signed_in_root_path(resource)
  end

  def authenticate_scope!
    send(:"authenticate_#{resource_name}!", force: true)
    self.resource = send(:"current_#{resource_name}")
  end

  def sign_up_params
    devise_parameter_sanitizer.sanitize(:sign_up)
  end

  def account_update_params
    devise_parameter_sanitizer.sanitize(:account_update)
  end

  def after_sign_out_path_for(resource)
   home_path
  end

  def update_sanitized_params
    devise_parameter_sanitizer.for(:sign_up) {|u| u.permit(:name, :organization_name, :email, :password, :password_confirmation, :plan_id)}
    # @plan_name = Plan.where(:id=> params[:plan_id]).pluck(:name)
  end

  def after_sign_in_path_for(resource)
    users_path(resource)
  end
end
