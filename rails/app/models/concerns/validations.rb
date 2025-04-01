# frozen_string_literal: true

module Validations
  extend ActiveSupport::Concern

  def validate_single_row_table
    return unless self.class.count.positive? && self.class.first.id != id

    errors.add(:base, I18n.t('errors.only_one_row'))
    throw(:abort)
  end
end
