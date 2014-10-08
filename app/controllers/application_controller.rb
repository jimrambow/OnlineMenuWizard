class ApplicationController < ActionController::Base
  include Concerns::Url

  before_filter :enable_tenant
 
  
  protect_from_forgery with: :exception
  
  def after_sign_out_path_for(resource)
   home_path
  end


  def enable_tenant
    @tenant = Tenant.new(current_user)
  end

end
