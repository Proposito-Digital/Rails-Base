# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApplicationController, type: :controller do

  let!(:tenant){
    create(:tenant) 
  }
  let!(:user) { create(:user, tenant: tenant) }


  before(:each) do 
    sign_in user
  end

end
