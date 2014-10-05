require 'rails_helper'

RSpec.describe "menus/index", :type => :view do
  before(:each) do
    assign(:menus, [
      Menu.create!(
        :title => "Title",
        :description => "MyText"
      ),
      Menu.create!(
        :title => "Title",
        :description => "MyText"
      )
    ])
  end

  it "renders a list of menus" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
