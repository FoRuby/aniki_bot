require 'bullet'

RSpec.shared_context 'bullet', bullet: true do
  before(:each) do
    Bullet.enable = true
    Bullet.bullet_logger = true
    Bullet.raise = true # raise an error if N+1 query occurs
    Bullet.start_request
  end

  after(:each) do
    Bullet.perform_out_of_channel_notifications if Bullet.notification?
    Bullet.end_request
    Bullet.enable = false
    Bullet.bullet_logger = false
    Bullet.raise = false
  end
end

RSpec.configure do |config|
  config.include_context 'bullet', bullet: true
end
