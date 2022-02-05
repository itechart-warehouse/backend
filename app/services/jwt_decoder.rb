class JwtDecoder

  def initialize(token)
    @token = token.split(' ').last
  end

  def initialized?
    @token.present?
  end

  def user_id
    return nil unless initialized?
    decode[0]['sub'].to_i
  end

  private
  def decode
    JWT.decode(@token, ENV['DEVISE_JWT_SECRET_KEY'], false, { algorithm: 'HS256' })
  end
end