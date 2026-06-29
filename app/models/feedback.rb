class Feedback < ApplicationRecord
  CATEGORIES = %w[idea bug like].freeze

  validates :category, inclusion: { in: CATEGORIES }
  validates :message,  presence: true, length: { maximum: 2000 }
  validates :email,    format: { with: URI::MailTo::EMAIL_REGEXP }, allow_blank: true
end
