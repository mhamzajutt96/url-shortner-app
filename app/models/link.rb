# frozen_string_literal: true

# :Link Model containing the validations and callbacks:
class Link < ApplicationRecord
  UNIQUE_ID_LENGTH = 6
  validates :original_url, presence: true, on: :create
  validates :original_url, format: URI::regexp(%w[http https])
  before_create :generate_short_url, :sanitize
  
  # GENERATE A UNIQUE URL FOR GIVEN WEB ADDRESS BEFORE SAVING INTO DATABASE
  def generate_short_url
    url = SecureRandom.uuid[0..5]
    old_url = Link.where(short_url: url).last
    if old_url.present?
      self.generate_short_url
    else
      self.short_url = url
    end
  end

  # CHECK IF ANY URL EXIST BEFORE SAVING IT TO DATABASE
  def find_duplicate
    Link.find_by_sanitize_url(self.sanitize_url)
  end

  def new_url?
    find_duplicate.nil?
  end
  
  # SANITIZE THE USER GIVEN URL
  def sanitize
    self.original_url.strip!
    self.sanitize_url = self.original_url.downcase.gsub(/(https?:\/\/)|(www\.)/, "")
    self.sanitize_url = "http://#{self.sanitize_url}"
  end
end
