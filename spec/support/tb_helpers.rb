module TbHelpers
  def operation_errors(operation, form: 'contract.default')
    operation[form.to_sym].errors.full_messages
  end
end

RSpec.configure do |config|
  config.include TbHelpers
end