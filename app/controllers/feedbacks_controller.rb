require 'base64'
require 'fileutils'
require 'securerandom'

class FeedbacksController < ApplicationController
  before_action :require_admin_key, only: [:index]

  def create
    feedback = Feedback.new(feedback_params)
    attach_screenshot(feedback, params[:screenshot_base64])

    if feedback.save
      render json: { success: true, id: feedback.id }, status: :created
    else
      render json: { errors: feedback.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    feedbacks = Feedback.order(created_at: :desc).limit(100)
    render json: feedbacks
  end

  private

  def require_admin_key
    expected = ENV['ADMIN_API_KEY'].presence
    provided = request.headers['X-Admin-Key'] || params[:api_key]
    return if expected && provided == expected
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  def feedback_params
    params.permit(
      :category, :message, :email,
      :screen, :app_version, :build_number,
      :platform, :os_version, :locale,
      :user_id, :device_model
    )
  end

  def attach_screenshot(feedback, base64_data)
    return if base64_data.blank?

    data = base64_data.sub(/\Adata:[^;]+;base64,/, '')
    filename = "#{Time.now.to_i}_#{SecureRandom.hex(6)}.jpg"
    dir = Rails.root.join('public', 'screenshots')
    FileUtils.mkdir_p(dir)
    File.binwrite(dir.join(filename), Base64.decode64(data))
    feedback.screenshot_filename = filename
  rescue => e
    Rails.logger.warn "Screenshot konnte nicht gespeichert werden: #{e.message}"
  end
end
