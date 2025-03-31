module Validations
  extend ActiveSupport::Concern

  def validate_single_row_table
    if self.class.count > 0 && self.class.first.id != id
      errors.add(:base, 'Only one row is allowed in this table.')
      throw(:abort)
    end
  end
end
