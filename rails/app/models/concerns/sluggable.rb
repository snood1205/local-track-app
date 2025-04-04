# frozen_string_literal: true

module Sluggable
  extend ActiveSupport::Concern

  included do
    validates :name, presence: true
    validates :slug, presence: true, uniqueness: { case_sensitive: false }, length: { maximum: 28 },
                     format: { with: /\A[a-z0-9][a-z0-9\-]+[a-z0-9]\z/ }

    before_validation :generate_slug, on: %i[create update]
  end

  def generate_slug
    if name.nil?
      errors.add(:name, 'Name cannot be nil')
    elsif slug.blank?
      slug_base = name.parameterize
      random_suffix_hex_size = (28 - slug_base.length - 1) / 2
      random_suffix = SecureRandom.hex(random_suffix_hex_size)
      self.slug = "#{slug_base}-#{random_suffix}"
    end
  end
end
