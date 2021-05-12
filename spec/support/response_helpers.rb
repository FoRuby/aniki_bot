module ResponseHelpers
  def create_payload(type: 'supergroup', callback: false)
    chat = case type
           when 'supergroup' then supergroup_chat
           when 'private' then private_chat
           else supergroup_chat
           end
    if callback
      {
        id: id,
        from: from,
        message: {
          message_id: message_id,
          from: from,
          chat: chat,
          date: date,
          text: text,
          entities: entities
        }
      }
    else
      {
        id: id,
        message_id: message_id,
        from: from,
        chat: chat,
        date: date,
        text: text,
        entities: entities
      }
    end
  end

  private

  def id
    'id'
  end

  def supergroup_chat
    { id: 'chat_id', title: 'ChatTitle', type: 'supergroup' }
  end

  def private_chat
    {
      id: 'chat_id',
      first_name: 'FirstName',
      last_name: 'LastName',
      username: 'UserName',
      type: 'private'
    }
  end

  def from
    {
      id: 'from_id',
      is_bot: false,
      first_name: 'FirstName',
      last_name: 'LastName',
      username: 'UserName',
      language_code: 'en'
    }
  end

  def message_id
    'message_id'
  end

  def date
    'date'
  end

  def text
    '/test'
  end

  def entities
    [{ offset: 0, length: 5, type: 'bot_command' }]
  end
end

RSpec.configure do |config|
  config.include ResponseHelpers, response: true
end