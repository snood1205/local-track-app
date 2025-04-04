# frozen_string_literal: true

class PaymentProcessor < ApplicationService
  include Square

  def initialize(total_in_cents, vendor_id, menu_item_id)
    super
    @payment = Payment.new(total_in_cents:, vendor_id:, menu_item_id:)
    bearer_auth_credentials = BearerAuthCredentials.new(access_token: ENV.fetch('SQUARE_ACCESS_TOKEN'))
    environment = ENV.fetch('SQUARE_ENVIRONMENT', 'sandbox')
    @client = Square::Client.new(bearer_auth_credentials:, environment:, timeout: 1)
  end

  def call
    raise InvalidPaymentError, @payment unless @payment.valid_to_process?
  end

  private

  attr_reader :payment, :client
end

class InvalidPaymentError < StandardError
  def initialize(payment)
    super
    @payment = payment
  end

  def message
    "Invalid payment: #{@payment.errors.full_messages.join(', ')}"
  end
end
