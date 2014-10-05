require 'rails_helper'

RSpec.describe "restaurants/edit", :type => :view do
  before(:each) do
    @restaurant = assign(:restaurant, Restaurant.create!(
      :name => "MyString",
      :description => "MyText",
      :slug => "MyString"
    ))
  end

  it "renders the edit restaurant form" do
    render

    assert_select "form[action=?][method=?]", restaurant_path(@restaurant), "post" do

      assert_select "input#restaurant_name[name=?]", "restaurant[name]"

      assert_select "textarea#restaurant_description[name=?]", "restaurant[description]"

      assert_select "input#restaurant_slug[name=?]", "restaurant[slug]"
    end
  end
end
