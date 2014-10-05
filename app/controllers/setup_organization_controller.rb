class SetupOrganizationController < ApplicationController
  include Wicked::Wizard
  steps :organization_setup

  def show
    @user = current_user
    case step
    when :organization_setup
      @organization = Organization.new
    end
    render_wizard
  end

end
