module Changelog
  module Response
    module Show
      class Success < Shared::Response::Success
        attr_reader :file_name

        def initialize(*args, input)
          super(*args)
          @file_name = "#{Rails.root}/CHANGELOG_#{input.first&.upcase}.md"
        end

        def success_respond
          data.split(/\n\n/).each { |p| bot.send_message chat_id: current_user.chat_id, text: p }
        end

        def data
          File.exist?(file_name) ? File.read(file_name) : File.read("#{Rails.root}/CHANGELOG_EN.md")
        end
      end
    end
  end
end
