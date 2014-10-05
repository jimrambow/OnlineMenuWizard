require 'rails_helper'

RSpec.describe "menus/edit", :type => :view do
  before(:each) do
    @menu = assign(:menu, Menu.create!(
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders the edit menu form" do
    render

    assert_select "form[action=?][method=?]", menu_path(@menu), "post" do

      assert_select "input#menu_title[name=?]", "menu[title]"

      assert_select "textarea#menu_description[name=?]", "menu[description]"
    end
  end
end
