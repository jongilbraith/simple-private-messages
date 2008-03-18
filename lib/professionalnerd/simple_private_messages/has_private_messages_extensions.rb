module Professionalnerd 
  module SimplePrivateMessages
    module HasPrivateMessagesExtensions
      def self.included(base) 
        base.extend ActMethods
      end 

      module ActMethods
        # Sets up a model have private messages, defining the child class as specified in :class_name.
        # Methods provided:
        # *  <tt>:sent_messages</tt> - returns a collection of messages for which this object is the sender.
        # *  <tt>:received_messages</tt> - returns a collection of messages for which this object is the recipient.
        def has_private_messages(options = {})
          options[:class_name] ||= 'Message'
          
          unless included_modules.include? InstanceMethods
            has_many :sent_messages,
                     :class_name => options[:class_name],
                     :foreign_key => 'sender_id',
                     :order => "created_at DESC",
                     :conditions => ["sender_deleted = ?", false]

            has_many :received_messages,
                     :class_name => options[:class_name],
                     :foreign_key => 'recipient_id',
                     :order => "created_at DESC",
                     :conditions => ["recipient_deleted = ?", false]

            extend ClassMethods 
            include InstanceMethods 
          end 
        end 
      end 

      module ClassMethods
      end

      module InstanceMethods
        # Returns the number of unread messages for this object
        def unread_message_count
          Message.count(:conditions => ["recipient_id = ? AND read_at IS NULL", self])
        end
      end 
    end
  end
end 
