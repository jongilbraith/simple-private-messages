module Professionalnerd # :nodoc:
  module SimplePrivateMessages # :nodoc:
    module PrivateMessageExtensions
      def self.included(base) # :nodoc:
        base.extend ActMethods
      end 

      module ActMethods
        # Sets up a model to be a private message model, defining the parent class as specified in :class_name (typically "User")
        # Provides the following instance methods:
        # *  <tt>sender</tt> - the sender of the message.
        # *  <tt>recipient</tt> - the recipient of the message.
        #
        # Also adds a named scopes of :read and :unread, to get, well, read and unread messages.
        def is_private_message(options = {})
          options[:class_name] ||= 'User'
          
          unless included_modules.include? InstanceMethods 
            belongs_to :sender,
                       :class_name => options[:class_name],
                       :foreign_key => 'sender_id'
            belongs_to :recipient,
                       :class_name => options[:class_name],
                       :foreign_key => 'recipient_id'

            extend ClassMethods 
            include InstanceMethods 
          end 

          scope :already_read, :conditions => "read_at IS NOT NULL"
          scope :unread, :conditions => "read_at IS NULL"
        end 
      end 

      module ClassMethods
        # Ensures the passed user is either the sender or the recipient then returns the message.
        # If the reader is the recipient and the message has yet not been read, it marks the read_at timestamp.
        def read(id, reader)
          message = find(id, :conditions => ["sender_id = ? OR recipient_id = ?", reader, reader])
          if message.read_at.nil? && reader == message.recipient
            message.read_at = Time.now
            message.save!
          end
          message
        end
      end

      module InstanceMethods
        # Returns true or false value based on whether the a message has been read by it's recipient.
        def read?
          self.read_at.nil? ? false : true
        end

        # Marks a message as deleted by either the sender or the recipient, which ever the user that was passed is.
        # Once both have marked it deleted, it is destroyed.
        # Added method argument count used to check if the message_content has to be destroyed
        def mark_deleted(user, count)
          self.sender_deleted = true if self.sender == user
          self.recipient_deleted = true if self.recipient == user
          # Removed
          # self.sender_deleted && self.recipient_deleted ? self.destroy : save!
          # Added the new logic
          mc = self.message_content
          if self.sender_deleted && self.recipient_deleted 
            self.destroy
            mc.destroy if count == 1
          else
             save!
          end
        end
      end 
    end
  end
end 

if defined? ActiveRecord
  ActiveRecord::Base.class_eval do
    include Professionalnerd::SimplePrivateMessages::PrivateMessageExtensions
  end
end