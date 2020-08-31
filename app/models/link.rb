# frozen_string_literal: true

# :Link Model containing the validations and callbacks:
class Link < ApplicationRecord
  
  # Validations
  validates_presence_of :url
  validates :url, format: URI::regexp(%w[http https])
  validates_uniqueness_of :slug
  validates_length_of :url, within: 3..255, on: :create, message: 'is too long'
  validates_length_of :slug, within: 3..255, on: :create, message: 'is too long'

  # Actions
  def short
    Rails.application.routes.url_helpers.short_url(slug: self.slug)
  end

  # Callbacks
  before_validation :generate_slug
  
  def generate_slug
    self.slug = SecureRandom.uuid[0..5] if self.slug.nil? || self.slug.empty?
  end
end
