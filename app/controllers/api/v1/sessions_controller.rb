# frozen_string_literal: true
class Api::V1::SessionsController < Api::V1::BaseController
  def login
    user = User.find_by_email(params[:user][:email])
    if user
      if user.valid_password?(params[:user][:password])
        user_access_token = SecureRandom.hex
        user.update(access_token: user_access_token, token_expiration_time: DateTime.now.in_time_zone)
        render json: [access_token: user_access_token]
      else
        errors = ['Email ou Senha Incorretos.']
        render(json: {status: 400, errors: errors})
      end
    else
      errors = ['Email ou Senha Incorretos.']
      render(json: {status: 400, errors: errors})
    end
  # rescue
  #   errors = ['Um cabeçalho HTTP necessário não foi especificado.']
  #   render(json: {status: 400, errors: errors})
  end
end