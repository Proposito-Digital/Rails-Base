# frozen_string_literal: true
require 'rails_helper'

RSpec.xdescribe "admin/users/new", type: :view do
  before(:each) do
    @instance = assign(:user, create(:user))
    sign_in @instance
  end

  it "renders new user form" do
    render
    assert_select "form[action=?][method=?]", admin_users_path(@instance), "post" do
    end
  end
end
