class ApplicationController < ActionController::API
  rescue_from StandardError, with: :internal_error

  private

  def internal_error(e)
    Rails.logger.error "[#{e.class}] #{e.message}"
    render json: { error: 'Interner Fehler' }, status: :internal_server_error
  end
end
