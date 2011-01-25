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

      end
    end
  end
end
