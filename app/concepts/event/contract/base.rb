module Event::Contract
  class Base < Reform::Form
    property :id
    property :name
    property :date
    property :status, prepopulator: :status!
    property :description

    property :event, virtual: true

    def status!(options)
      self.status = options[:status]
    end
  end
end