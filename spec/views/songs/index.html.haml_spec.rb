require 'rails_helper'

RSpec.describe "songs/index", type: :view do
  before(:each) do
    assign(:songs, [
      Song.create!(
        :name => "Name",
        :guid => "Guid"
      ),
      Song.create!(
        :name => "Name",
        :guid => "Guid"
      )
    ])
  end

  it "renders a list of songs" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Guid".to_s, :count => 2
  end
end
