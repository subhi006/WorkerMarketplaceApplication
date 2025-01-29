class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.ransackable_attributes(_auth_object = nil)
    [ "location", "company", "category_id", "experience" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "applications", "category", "contractor", "workers", "profile" ]
  end
end
