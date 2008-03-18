module Professionalnerd 
  module SimplePrivateMessages
    module PrivateMessageExtensions
      def self.included(base) 
        base.extend ActMethods
      end 

      module ActMethods
        # Sets up a model to be a private message model, defining the parent class as specified in :class_name.
        # Methods provided:
        # *  <tt>:sender</tt> - the sender of the message.
        # *  <tt>:recipient</tt> - the recipient of the message.
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
        end 
      end 

      module ClassMethods
        # Ensures the passed object is either the sender or the recipient then returns the message.
        # If the reader is the recipient and the message has yet not been read, it marks the read_at timestamp.
        def read(id, reader, options = {})
          message = find(id, :conditions => ["sender_id = ? OR recipient_id = ?", reader, reader])
          if message.read_at.nil? && reader == message.recipient
            message.read_at = Time.now
            message.save!
          end
          message
        end
      end

      module InstanceMethods
        # Returns a boolean value based on whether the recipient has read the message
        def read?
          self.read_at.nil? ? false : true
        end

        # Marks the message as deleted by either the sender or the recipient, which ever the object that was passed is.
        # Once both have marked it delete, it is destroyed.
        def mark_deleted(object)
          self.sender_deleted = true if self.sender == object
          self.recipient_deleted = true if self.recipient == object
          self.sender_deleted && self.recipient_deleted ? self.destroy : save!
        end
      end 
    end
  end
end 
