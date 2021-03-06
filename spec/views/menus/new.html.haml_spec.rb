require 'rails_helper'

RSpec.describe "menus/new", :type => :view do
  before(:each) do
    assign(:menu, Menu.new(
      :title => "MyString",
      :description => "MyText"
    ))
  end

  it "renders new menu form" do
    render

    assert_select "form[action=?][method=?]", menus_path, "post" do

      assert_select "input#menu_title[name=?]", "menu[title]"

      assert_select "textarea#menu_description[name=?]", "menu[description]"
    end
  end
end
