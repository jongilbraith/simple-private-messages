require 'rails/generators'
require 'rails/generators/migration'

module SimplePrivateMessages
module Generators
class ModelGenerator < Rails::Generators::Base
	include Rails::Generators::Migration
	
	desc "Creates the private message model."
	
	argument :user_model_name, :required => false, :default => "User", :desc => "The user model name"
	argument :message_model_name, :required => false, :default => "Message", :desc => "The message model name"

  attr_reader :singular_camel_case_name, :plural_camel_case_name, :singular_lower_case_name, :plural_lower_case_name
  attr_reader :singular_camel_case_parent, :plural_camel_case_parent, :singular_lower_case_parent, :plural_lower_case_parent
	
	def self.source_root
    	File.join(File.dirname(__FILE__), 'templates')
	end

   # Implement the required interface for Rails::Generators::Migration.
   # taken from http://github.com/rails/rails/blob/master/activerecord/lib/generators/active_record.rb
  def self.next_migration_number(dirname) #:nodoc:
    if ActiveRecord::Base.timestamped_migrations
      Time.now.utc.strftime("%Y%m%d%H%M%S")
    else
      "%.3d" % (current_migration_number(dirname) + 1)
    end
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
		
		#directory "app/models"
		template "model.rb", "app/models/#{singular_lower_case_name}.rb"
			
		migration_template "migration.rb", "db/migrate/create_#{plural_lower_case_name}", :assigns => {
			:migration_name => "Create#{plural_camel_case_name}"
		}
	end
end
end
end