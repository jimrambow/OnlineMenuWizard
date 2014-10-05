class OrganizationsUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :organization_name, :string
  end
end
