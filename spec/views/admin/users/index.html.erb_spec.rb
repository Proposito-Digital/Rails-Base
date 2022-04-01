# frozen_string_literal: true
require 'rails_helper'
require 'will_paginate/array'


RSpec.xdescribe "admin/users/index", type: :view do
  let(:user){
    create(:user)
  }

  before(:each) do
  	sign_in user
    assign(:instances, [
       create(:user),
       create(:user),
       create(:user),
       create(:user)
    ].paginate(per_page: 2))
  end

  it "renders a list of users" do
    enable_pundit(view, user)
    render
  end
end
