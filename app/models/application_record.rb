class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def self.random
    order("random()").first
  end
end
