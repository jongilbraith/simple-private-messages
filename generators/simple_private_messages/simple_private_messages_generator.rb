class SimplePrivateMessagesGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      m.directory "app/models"
      
      m.template "private_message_model.rb", "app/models/#{file_name}.rb"
      
      unless options[:skip_migration] 
        m.migration_template "private_messages_migration.rb", "db/migrate", :assigns => {
          :migration_name => "Create#{class_name.pluralize.gsub(/::/, '')}"
        }, :migration_file_name => "create_#{file_path.gsub(/\//, '_').pluralize}"
      end
    end
  end
end
