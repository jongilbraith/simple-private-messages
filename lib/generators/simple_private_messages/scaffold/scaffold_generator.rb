require 'rails/generators'

module SimplePrivateMessages
module Generators
class ScaffoldGenerator < Rails::Generators::Base
  	desc "Creates a basic controller and a set of views."
  
	argument :user_model_name, :required => false, :default => "User", :desc => "The user model name"
	argument :message_model_name, :required => false, :default => "Message", :desc => "The message model name"
    
  attr_reader :singular_camel_case_name, :plural_camel_case_name, :singular_lower_case_name, :plural_lower_case_name
  attr_reader :singular_camel_case_parent, :plural_camel_case_parent, :singular_lower_case_parent, :plural_lower_case_parent

	def self.source_root
    	File.join(File.dirname(__FILE__), 'templates')
	end
  
  def go
    @singular_camel_case_name = message_model_name.singularize.camelize
    @plural_camel_case_name = message_model_name.pluralize.camelize
    @singular_lower_case_name = message_model_name.singularize.underscore
    @plural_lower_case_name = message_model_name.pluralize.underscore

    @singular_camel_case_parent = user_model_name.singularize.camelize
    @plural_camel_case_parent = user_model_name.pluralize.camelize
    @singular_lower_case_parent = user_model_name.singularize.underscore
    @plural_lower_case_parent = user_model_name.pluralize.underscore    
  
    route("resources :#{@plural_lower_case_parent} do
             resources :#{@plural_lower_case_name} do
               collection do
                 post :delete_selected
               end
             end
           end")
  
      #directory "app/controllers"
      template "controller.rb", "app/controllers/#{@plural_lower_case_name}_controller.rb"

      #directory "app/views"
      #directory "app/views/#{@plural_lower_case_name}"
      template "view_index.html.erb", "app/views/#{@plural_lower_case_name}/index.html.erb"
      template "view_index_inbox.html.erb", "app/views/#{@plural_lower_case_name}/_inbox.html.erb"
      template "view_index_sent.html.erb", "app/views/#{@plural_lower_case_name}/_sent.html.erb"
      template "view_show.html.erb", "app/views/#{@plural_lower_case_name}/show.html.erb"
      template "view_new.html.erb", "app/views/#{@plural_lower_case_name}/new.html.erb"
  end
end
end
end
