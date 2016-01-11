require 'rails_helper'

RSpec.describe "presents/show", type: :view do
  before(:each) do
    @present = assign(:present, Present.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
