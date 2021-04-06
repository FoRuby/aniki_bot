module Event::Contract
  class Close < Reform::Form
    property :id
    property :status, prepopulator: ->(options) { self.status = options[:status] }
    property :event, virtual: true

    validation contract: ::Event::Validation::Close.new
  end
end