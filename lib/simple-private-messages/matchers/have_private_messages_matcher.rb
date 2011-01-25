module Professionalnerd # :nodoc:
  module SimplePrivateMessages # :nodoc:
    module Shoulda # :nodoc:
      module Matchers # :nodoc:

        def be_private_message
          BePrivateMessage.new
        end

        class BePrivateMessage
          def matches? subject
            @subject = subject
            @subject = @subject.class unless Class === @subject
            included?
          end

          def failure_message
            "Should be private message"
          end

          def negative_failure_message
            "Should not be private message"
          end

          def description
            "is private message"
          end

          protected

          def included?
            @subject.ancestors.include?(Professionalnerd::SimplePrivateMessages::PrivateMessageExtensions::InstanceMethods)
          end
        end

        def have_private_messages
          HavePrivateMessagesMatcher.new
        end

        class HavePrivateMessagesMatcher # :nodoc:

          def matches? subject
            @subject = subject
            @subject = @subject.class unless Class === @subject
            included?
          end

          def failure_message
            "Should have 'has_private_messages' method"
          end

          def negative_failure_message
            "Should not have 'has_private_messages' method"
          end

          def description
            "have private messages"
          end

          protected

          def included?
            @subject.ancestors.include?(Professionalnerd::SimplePrivateMessages::HasPrivateMessagesExtensions::InstanceMethods)
          end
        end
      end
    end
  end
end
