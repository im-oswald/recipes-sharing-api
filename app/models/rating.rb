# frozen_string_literal: true

class Rating < ApplicationRecord
  # associations go here
  belongs_to :recipe
  belongs_to :user

  # validations go here
  validates :rated_as, length: { minimum: 0, maximum: 10, message: I18n.t('.invalid_rating') }, presence: true
  validates :user_id, uniqueness: { scope: :recipe_id, message: I18n.t('.rating_exists') }
end