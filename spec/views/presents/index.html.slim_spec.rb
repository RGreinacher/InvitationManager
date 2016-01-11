require 'rails_helper'

RSpec.describe "presents/index", type: :view do
  before(:each) do
    assign(:presents, [
      Present.create!(),
      Present.create!()
    ])
  end

  it "renders a list of presents" do
    render
  end
end
