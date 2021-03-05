module Event::Contract
  class Close < Reform::Form
    property :id
    property :status

    validation contract: ::Event::Validation::Close.new
  end
end