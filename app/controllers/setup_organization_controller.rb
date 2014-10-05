class SetupOrganizationController < ApplicationController
  include Wicked::Wizard
  steps :organization_setup

end
