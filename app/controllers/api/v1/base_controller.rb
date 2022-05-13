# frozen_string_literal: true
class Api::V1::BaseController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :destroy_session
  before_action :authenticate

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

	def destroy_session
		request.session_options[:skip] = true
	end

	# def not_found
	# 	render(json: {status: 404, errors: 'Not found'})
	# end

private
 
  def authenticate
  	api_key = request.headers['api-key']
  	api_key = ApiKey.where(access_token: api_key).first if api_key
		
	  unless api_key
	    errors = ['A HTTP header has not specified']
    	render(json: {status: 400, errors: errors})
	  end
  end

	def authenticated_user?
		access_token = request.headers['access-token']
		user = User.where(access_token: access_token).first if access_token

		unless user && user.access_token_expired?
	    	errors = ['Access token expired']
    		render(json: {status: 400, errors: errors})
	  	end
	end
end
