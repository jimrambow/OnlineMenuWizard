require 'rails_helper'

RSpec.describe "menus/show", :type => :view do
  before(:each) do
    @menu = assign(:menu, Menu.create!(
      :title => "Title",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
  end
end
