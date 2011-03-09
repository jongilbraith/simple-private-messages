require "pathname"

puts "\nCopy all jQuery javascript files from vendor/plugins/simple-private-messages/javascripts to:\n  " + (Pathname.getwd + "javascripts")
puts "\nCopy all CSS stylesheets and images files from vendor/plugins/simple-private-messages/stylesheets to:\n  " + (Pathname.getwd + "stylesheets")

puts "
Add the following line on top (Between <head> ... </head> tag) of your app/view/layout/application.html.erb file:

<%= yield :simple_private_messages %>
"