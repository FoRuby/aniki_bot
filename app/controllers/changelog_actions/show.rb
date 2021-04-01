module ChangelogActions
  module Show
    def changelog!(*args)
      file_name = "#{Rails.root}/CHANGELOG_#{args.first&.upcase}.md"
      data = File.exist?(file_name) ? File.read(file_name) : File.read("#{Rails.root}/CHANGELOG_EN.md")
      bot.send_message chat_id: current_user.chat_id, text: data
    end
  end
end
