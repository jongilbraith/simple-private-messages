class <%= singular_camel_case_name %> < ActiveRecord::Base

  is_private_message<% unless singular_camel_case_parent == "User" %> :class_name => "<%= "#{singular_camel_case_parent}" %>"<% end %>
  
  belongs_to :<%= singular_lower_case_name + '_content' %>

end