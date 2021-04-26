module User::Contract
  class Create < User::Contract::Base
    validation contract: ::User::Validation::Create.new
  end
end