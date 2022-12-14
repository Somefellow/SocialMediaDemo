# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  self.implicit_order_column = 'created_at'

  before_create :generate_id

  def generate_id
    self.id = SecureRandom.uuid
  end
end
