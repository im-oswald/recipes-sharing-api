module Exceptions
  class AuthenticationError < StandardError; end

  def self.print_error(error, message = nil)
    # To notify on airbrake or any similar tool
    # Airbrake.notify(error)

    # Slack or any other tools for notification goes here

    Rails.logger.error "EXCEPTION: #{message || error.message}"
    Rails.logger.debug error.backtrace.join("\r\n")
  end
end
