# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
    describe " SessionsController #{}" do
      let(:tenant){
        create(:tenant) 
      }
      let(:user) {create(:user, tenant: tenant)}
      let(:apikey){ ApiKey.create }

      it "get access token from login" do
        request.headers['api-key'] = apikey.access_token
        post "login", params: {user: {email: user.email, password: "teste@123"}}, :format => :json
        expect(response.body).to include "access_token"
        expect(response).to have_http_status(200)
      end

      it "try to get access token with e-mail wrong" do
        request.headers['api-key'] = apikey.access_token
        post "login", params: {user: {email: "casa@casa.com", password: "teste@123"}}, :format => :json
        expect(response.body).to include "errors"
        expect(response.body).to include "400"
        expect(response).to have_http_status(200)
      end

      it "try to get access token with password wrong" do
        request.headers['api-key'] = apikey.access_token
        post "login", params: {user: {email: user.email, password: "casa"}}, :format => :json
        expect(response.body).to include "errors"
        expect(response.body).to include "400"
        expect(response).to have_http_status(200)
      end

       it "try to get access token without a API-KEY" do
        post "login", params: {}, :format => :json
        expect(response.body).to include "A HTTP header has not specified"
        expect(response.body).to include "errors"
        expect(response.body).to include "400"
        expect(response).to have_http_status(200)
      end

    end

end
