class <%= "Create#{singular_camel_case_name}Contents" %> < ActiveRecord::Migration
  def self.up
    create_table :<%= singular_lower_case_name + "_contents" %> do |t|
      t.string :subject
      t.text :body
      t.timestamps
    end
  end

  def self.down
    drop_table <%= singular_lower_case_name + "_contents" %>
  end
end