# frozen_string_literal: true
require 'rails_helper'
RSpec.describe Admin::UsersHelper, type: :helper do

  let(:user) { create(:user)  }

  before(:each) do
  	sign_in user
  end

  describe "#put_edit_all_users_password_action" do

    xit "deprecate test" do
      expect(helper.put_edit_all_users_password_action(user)).to include "<i class='fa fa-cog'><\/i>"
    end

  end 

end