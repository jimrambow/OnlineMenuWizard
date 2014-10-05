class OrganizationsController < ApplicationController

  before_action :set_organization, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!, except: [:new] 

  def index
    @organizations = Organization.where(:name => request.subdomain).first
  end

  def show
  end

  def new
    @organization = Organization.new
    @plan = Plan.where(:id=> params[:plan_id]).pluck(:name)
  end

  def edit
     @organization.users.each do |u|
      if u.plan_id.present?
  @plan = Plan.where(:id=> u.plan_id).pluck(:name)
      end
     end
  end

  def create
    @user = current_user
    @organization = Organization.new(organization_params)
    @organization.users << @user

     
    respond_to do |format|
      if @organization.save
        format.html { redirect_to @organization, notice: 'Organization was successfully created.' }
        format.json { render action: 'show', status: :created, location: @organization }
      else
        format.html { render action: 'new' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @organization.update(organization_params)
        format.html { redirect_to dashboard_path, notice: 'Organization was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @organization.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @organization.destroy
    respond_to do |format|
      format.html { redirect_to organizations_url }
      format.json { head :no_content }
    end
  end

  private

    def set_organization
      @organization = Organization.find(params[:id])
    end

    def organization_params
      params.require(:organization).permit(:name, :description, :plan_id, {:user_ids => []})
    end
end
