class Contact < ActiveRecord::Base
  scope :character_pattern, ->(like_value){where("name like ?",like_value)}
   scope :numeric_pattern, ->(like_value){where("number like ?",like_value)}
  # scope :character_at_two, ->{where("name like ?","_r%")}



end
