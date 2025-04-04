# frozen_string_literal: true

class Payment < ApplicationRecord
  belongs_to :menu_item, optional: true
  belongs_to :vendor, optional: false

  validate :menu_item_belongs_to_vendor
  validates :transaction_code, presence: true
  validates :total_in_cents, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def valid_to_process?
    valid? # call to run all validations

    errors.count == 1 && errors.first.attribute == :transaction_code && errors.first.type == :blank
  end

  private

  def menu_item_belongs_to_vendor
    return if menu_item.nil? || menu_item.vendor_id == vendor_id

    errors.add(:menu_item, 'must belong to the same vendor as the payment')
  end
end
