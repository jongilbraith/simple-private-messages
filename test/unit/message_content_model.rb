require File.dirname(__FILE__) + '/../test_helper'

class MessageModelTest < Test::Unit::TestCase

  def setup
    @mc1 = create_message_content(:subject => "To many", :body => "Many: Test content!")
    @mc2 = create_message_content(:subject => "To one", :body => "One: Test content!")
    @message = create_message
  end

end