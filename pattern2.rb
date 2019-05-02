require 'pry'

class ApiStatus
  STATUSES = [:success, :failure, :pending].freeze

  class << self
    STATUSES.each do |status|
      define_method status do |error = nil|
        new(status, error)
      end
    end
  end

  attr_accessor :error

  def initialize(status, error = nil)
    @status = status
    @error  = error
  end

  STATUSES.each do |status|
    define_method "on_#{status}" do |&block|
      block.call(error) if @status == status
    end
  end
end


status = ApiStatus.success

status.on_success do
  puts "success"
end

status = ApiStatus.failure("Unknown")

status.on_failure do |error|
  puts "failure #{error}"
end

# Usage with if condition

api_status = ApiCall.new(params).perform

if api_status == "success"
  # handle success
elsif api_status == "failure"
  # handle failure
elsif api_status == "pending"
  # handle pending
else
  "do nothing"
end

# Usage with status object
status = ApiStatus.send(:api_status)

status.on_success do
  # handle success
end

status.on_failure do |error|
  # handle failure
end

status.on_pending do
  # handle pending
end

