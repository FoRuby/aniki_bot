module Event::Contract
  class Edit < Reform::Form
    property :id

    validation contract: ::Event::Validation::Edit.new
  end
end