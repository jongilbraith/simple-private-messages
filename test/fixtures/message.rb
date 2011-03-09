class Message < ActiveRecord::Base
  is_private_message
  
  belongs_to :message_content
end