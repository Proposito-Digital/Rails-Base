# frozen_string_literal: true
require 'rails_helper'

RSpec.xdescribe "admin/users/edit", type: :view do
	before(:each) do
		@instance = assign(:user, create(:user))
	end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", admin_user_path(@instance), "post" do
    end
  end
end
