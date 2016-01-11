require 'rails_helper'

RSpec.describe "presents/new", type: :view do
  before(:each) do
    assign(:present, Present.new())
  end

  it "renders new present form" do
    render

    assert_select "form[action=?][method=?]", presents_path, "post" do
    end
  end
end
