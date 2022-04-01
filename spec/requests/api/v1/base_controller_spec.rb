# frozen_string_literal: true
require 'rails_helper'

describe "Request to API", :type => :request do
  it 'login' do
  	apikey = ApiKey.create

  	 headers = {
      "ACCEPT" => "application/json",     
      "api-key" => apikey.access_token,     
    }

    create(:user, email: "teste@teste.com.br", password: "teste123", password_confirmation: "teste123")

    post '/api/v1/login', params: { user: {email: "teste@teste.com.br", password: "teste123"} }, headers: headers

    # test for the 200 status-code
    expect(response).to be_successful

    # check to make sure the right amount of messages are returned
    expect(response.content_type).to include("application/json")
    expect(response.body).to include("access_token")
  end
end