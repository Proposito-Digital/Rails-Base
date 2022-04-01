# frozen_string_literal: true
require 'rails_helper'

RSpec.xdescribe "admin/users/show", type: :view do
  before(:each) do
    @instance = assign(:user, create(:user))
  end

  it "renders attributes in <p>" do
    render
  end
end
