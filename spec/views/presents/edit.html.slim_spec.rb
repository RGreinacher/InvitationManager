require 'rails_helper'

RSpec.describe "presents/edit", type: :view do
  before(:each) do
    @present = assign(:present, Present.create!())
  end

  it "renders the edit present form" do
    render

    assert_select "form[action=?][method=?]", present_path(@present), "post" do
    end
  end
end
