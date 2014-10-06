class ApplicationController < ActionController::Base
  include Concerns::Url
  before_filter :enable_tenant
  protect_from_forgery with: :exception

  # def enable_tenant
  #   @current_tenant || = Tenant.new(current_user.organization)
  # end
  
  def after_sign_out_path_for(resource)
   home_path
  end


  def enable_tenant
    @tenant = Tenant.new(current_user)
  end

end
