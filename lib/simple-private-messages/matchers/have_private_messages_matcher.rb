module Professionalnerd # :nodoc:
  module SimplePrivateMessages # :nodoc:
    module Shoulda # :nodoc:
      module Matchers # :nodoc:

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
