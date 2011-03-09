class <%= singular_camel_case_name + "Content" %> < ActiveRecord::Base
  
  # Process only attributes that comes from the html post
  attr_accessor :to, :no_save
  
  # Process only attributes that comes from the html post
  attr_accessible :to, :no_save, :subject, :body
  
  # Relations between models
  has_many :<%= plural_lower_case_name %>
  
  # Validations of all attributes
  validates_presence_of      :subject
  validates_presence_of      :body
  validates_presence_of      :to
  validates_inclusion_of     :no_save,        :in => ['false', 'true'],
                                              :allow_nil => true
  
end