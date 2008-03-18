class <%= "Create#{class_name.pluralize}" %> < ActiveRecord::Migration
  def self.up
    create_table <%= "#{file_name.pluralize}" %> do |t|
      t.integer :sender_id, :recipient_id
      t.boolean :sender_deleted, :recipient_deleted, :default => 0
      t.string :subject
      t.text :body
      t.datetime :read_at
      t.timestamps
    end
  end

  def self.down
    drop_table <%= "#{file_name.pluralize}" %>
  end
end