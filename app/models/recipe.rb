class Recipe < ApplicationRecord
  include ConstantValidatable

  DIFFICULTIES = %w[easy normal challenging]

  # jitera-anchor-dont-touch: relations

  has_many :ingredients, dependent: :destroy

  has_many :ratings, dependent: :destroy
  has_many :users, through: :ratings

  belongs_to :category

  belongs_to :user

  # jitera-anchor-dont-touch: enum
  enum difficulty: DIFFICULTIES, _suffix: true

  # jitera-anchor-dont-touch: file

  # jitera-anchor-dont-touch: validation

  validates :title, length: { maximum: 255, minimum: 0, message: I18n.t('.out_of_range_error') }, presence: true

  validates :descriptions, length: { maximum: 65_535, minimum: 0, message: I18n.t('.out_of_range_error') },
                           presence: true

  validates :time, length: { maximum: 255, minimum: 0, message: I18n.t('.out_of_range_error') }, presence: true

  validates :difficulty, presence: true

  accepts_nested_attributes_for :ingredients

  # scopes
  scope :by_title, -> (title) { where("title like '%#{title}%'") }
  scope :by_difficulty, -> (difficulty) { where(difficulty: difficulty) }
  scope :time_between, -> (start_time, end_time) { where("time >= ? AND time <= ?", start_time, end_time) }

  def self.associations
    [:ingredients]
  end

  # jitera-anchor-dont-touch: reset_password

  class << self
  end
end
