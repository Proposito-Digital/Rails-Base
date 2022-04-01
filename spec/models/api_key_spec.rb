# frozen_string_literal: true
require 'rails_helper'

RSpec.describe ApiKey, type: :model do

	subject(:apikey){ ApiKey.create }

	it "create apikey and have a access token" do
		expect(apikey.access_token.length).to be SecureRandom.hex.length 
	end

end
