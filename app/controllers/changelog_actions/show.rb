module ChangelogActions::Show
  def changelog!(*args)
    data = File.read("#{Rails.root}/CHANGELOG_RU.md")
    bot.send_message chat_id: current_user.chat_id, text: data
  end
end
