# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Payment do
  subject(:payment) { create(:payment, menu_item:, vendor:) }

  let(:vendor) { create(:vendor) }
  let(:menu_item) { create(:menu_item, vendor:) }

  describe 'associations' do
    it { is_expected.to belong_to(:menu_item).optional }
    it { is_expected.to belong_to(:vendor).required }
  end

  describe 'validations' do
    let(:other_vendor) { create(:vendor) }
    let(:menu_item_with_other_vendor) { create(:menu_item, vendor: other_vendor) }
    let(:invalid_payment) { build(:payment, menu_item: menu_item_with_other_vendor, vendor:) }
    let(:valid_payment) { build(:payment, vendor: other_vendor, menu_item: menu_item_with_other_vendor) }

    before do
      invalid_payment.valid?
      valid_payment.valid?
    end

    it { is_expected.to validate_presence_of(:transaction_code) }
    it { is_expected.to validate_presence_of(:total_in_cents) }
    it { is_expected.to validate_numericality_of(:total_in_cents).only_integer.is_greater_than_or_equal_to(0) }

    it { expect(invalid_payment).not_to be_valid }
    it { expect(invalid_payment.errors[:menu_item]).to include('must belong to the same vendor as the payment') }

    it { expect(valid_payment).to be_valid }
  end

  describe '#valid_to_process?' do
    let(:vendor) { create(:vendor) }
    let(:menu_item) { create(:menu_item, vendor:) }

    context 'when transaction_code is blank but all else is there' do
      subject { build(:payment, transaction_code: nil, total_in_cents: 100, vendor:, menu_item:) }

      it { is_expected.to be_valid_to_process }
    end

    context 'when transaction_code is present with everything else' do
      subject { build(:payment, transaction_code: '12345', total_in_cents: 100, vendor:, menu_item:) }

      it { is_expected.not_to be_valid_to_process }
    end

    context 'when there is a blank transaction_code but no vendor' do
      subject { build(:payment, transaction_code: nil, total_in_cents: 100, vendor: nil, menu_item:) }

      it { is_expected.not_to be_valid_to_process }
    end

    context 'when there is a blank transaction_code but no total_in_cents' do
      subject { build(:payment, transaction_code: nil, total_in_cents: nil, vendor:, menu_item:) }

      it { is_expected.not_to be_valid_to_process }
    end

    context 'when there is a blank transaction_code but no vendor and total_in_cents' do
      subject { build(:payment, transaction_code: nil, total_in_cents: nil, vendor: nil, menu_item:) }

      it { is_expected.not_to be_valid_to_process }
    end

    context 'when all attributes are blank' do
      subject { build(:payment, transaction_code: nil, total_in_cents: nil, vendor: nil, menu_item: nil) }

      it { is_expected.not_to be_valid_to_process }
    end

    context 'when there are other validation errors' do
      subject { build(:payment, transaction_code: nil, total_in_cents: -1, vendor:, menu_item:) }

      it { is_expected.not_to be_valid_to_process }
    end
  end
end
