class <%= "Create#{plural_camel_case_name}" %> < ActiveRecord::Migration
  def self.up
    create_table :<%= plural_lower_case_name %> do |t|
      t.integer :sender_id, :recipient_id
      t.boolean :sender_deleted, :recipient_deleted, :default => 0
      t.references :<%= singular_lower_case_name + "_content" %>
      t.datetime :read_at
      t.timestamps
    end
  end

  def self.down
    drop_table <%= plural_lower_case_name %>
  end
end
