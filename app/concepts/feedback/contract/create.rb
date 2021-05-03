module Feedback::Contract
  class Create < Reform::Form
    property :message
    property :user_id

    validation contract: ::Feedback::Validation::Create.new
  end
end