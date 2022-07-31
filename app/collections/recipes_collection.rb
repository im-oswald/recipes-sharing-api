# frozen_string_literal: true

class RecipesCollection < BaseCollection
  private

  def sort_columns
    %w(title difficulty time)
  end

  def ensure_filters
    filter_by_title if params[:title].present?
    filter_by_time if params[:time].present?
    filter_by_difficulty if params[:difficulty].present?
  end

  def filter_by_title
    filter { @relation.by_title(params[:title]) }
  end

  def filter_by_time
    filter { @relation.time_between(start_time, end_time) }
  end

  def filter_by_difficulty
    filter { @relation.by_difficulty(params[:difficulty]) }
  end

  def time
    params[:time].gsub(/\s+/, '')
  end

  def start_time
    UnitConverter.call(time.split('-').first, :min)
  end

  def end_time
    UnitConverter.call(time.split('-').last, :min)
  end
end
