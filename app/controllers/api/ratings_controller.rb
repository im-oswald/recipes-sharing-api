# frozen_string_literal: true

class Api::RatingsController < Api::BaseController
  before_action :find_rating, only: :destroy
  before_action :set_rating, only: :create
  before_action :doorkeeper_authorize!, only: :destroy
  before_action :current_user_authenticate, only: :destroy

  def destroy
    @error_message = true unless @rating&.destroy
  end

  def create
    @rating.assign_attributes(rating_params)
    @error_object = @rating.errors.messages unless @rating.save
  end

  private

  def rating_params
    params.require(:rating).permit(%i(user_id rated_as)).merge({ recipe_id: params[:recipe_id] })
  end

  def find_rating
    @rating ||= Rating.find_by(id: params[:id])
  end

  def set_rating
    @rating ||= Rating.new
  end
end
