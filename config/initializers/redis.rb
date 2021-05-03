REDIS = Redis.new(url: URI.parse(Rails.application.credentials.dig(:redis, :url)))
