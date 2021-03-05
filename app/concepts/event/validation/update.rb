module Event::Validation
  class Update < Event::Validation::Edit
    DATE_FORMAT = /\A\d{4}-\d{2}-\d{2} \d{2}:\d{2}(:\d{2})?\z/.freeze

    params do
      required(:name).filled(:string)
      required(:date).filled(:string, format?: DATE_FORMAT)
    end

    rule :date do
      key.failure(:already_past) if value.to_time.past?
    end
  end
end
