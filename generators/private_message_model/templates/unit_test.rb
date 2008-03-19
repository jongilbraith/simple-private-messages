require File.dirname(__FILE__) + '/../test_helper'

class <%= singular_camel_case_name %>Test < Test::Unit::TestCase
  
  def setup
    @jerry = <%= "#{singular_camel_case_parent}" %>.find(1)
    @george = <%= "#{singular_camel_case_parent}" %>.find(2)
    @<%= singular_lower_case_name %> = create_<%= singular_lower_case_name %>
  end

  # These are actual tests for the <%= "#{singular_camel_case_parent}" %> model and should be moved to it's unit test
  def test_unread_<%= plural_lower_case_name %>?
    assert @jerry.unread_<%= plural_lower_case_name %>?
  end

  def test_unread_<%= singular_lower_case_name %>_count
    assert_equal @jerry.unread_<%= singular_lower_case_name %>_count, 1
  end

  # These are the actual <%= singular_camel_case_name %> model tests
  def test_create_<%= singular_lower_case_name %>
    @<%= singular_lower_case_name %> = create_<%= singular_lower_case_name %>
    
    assert_equal @<%= singular_lower_case_name %>.sender, @george
    assert_equal @<%= singular_lower_case_name %>.recipient, @jerry
    assert_equal @<%= singular_lower_case_name %>.subject, "Frolf, Jerry!"
    assert_equal @<%= singular_lower_case_name %>.body, "Frolf, Jerry! Frisbee golf!"
    assert @<%= singular_lower_case_name %>.read_at.nil?
  end

  def test_read_returns_<%= singular_lower_case_name %>
    assert_equal @<%= singular_lower_case_name %>, <%= singular_camel_case_name %>.read(@<%= singular_lower_case_name %>, @george)
  end

  def test_read_records_timestamp
    assert !@<%= singular_lower_case_name %>.nil?
  end
  
  def test_read?
    <%= singular_camel_case_name %>.read(@<%= singular_lower_case_name %>, @jerry)
    @<%= singular_lower_case_name %>.reload
    assert @<%= singular_lower_case_name %>.read?
  end
  
  def test_mark_deleted_sender
    @<%= singular_lower_case_name %>.mark_deleted(@george)
    @<%= singular_lower_case_name %>.reload
    assert @<%= singular_lower_case_name %>.sender_deleted
  end

  def test_mark_deleted_recipient
    @<%= singular_lower_case_name %>.mark_deleted(@jerry)
    @<%= singular_lower_case_name %>.reload
    assert @<%= singular_lower_case_name %>.recipient_deleted
  end

  def test_mark_deleted_both
    id = @<%= singular_lower_case_name %>.id
    @<%= singular_lower_case_name %>.mark_deleted(@jerry)
    @<%= singular_lower_case_name %>.mark_deleted(@george)
    assert !<%= singular_camel_case_name %>.exists?(id)
  end
  
  private
    def create_<%= singular_lower_case_name %>(options = {})
      return <%= singular_camel_case_name %>.create({:sender => @george,
                             :recipient => @jerry,
                             :subject => "Frolf, Jerry!",
                             :body => "Frolf, Jerry! Frisbee golf!"}.merge(options))
    end
end