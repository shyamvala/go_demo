require 'spec_helper'

describe "home/index" do
  it "should have the welcome text" do
    render
    rendered.should have_content("Welcome to Go Demo")
  end
end
