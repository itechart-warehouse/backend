class CompanyController < ApplicationController
  respond_to :json
  require_relative '../services/jwt_decoder'

  def create
    if request.headers['Authorization']
      decoder = JwtDecoder.new(request.headers['Authorization'])
      user = User.find_by(id: decoder.user_id)
      p user
      #TODO: create company for this user
    else
      render json: { error: 'No Authorization header' }, status: 401
    end
  end

end
