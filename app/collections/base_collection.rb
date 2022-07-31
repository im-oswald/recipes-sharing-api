# frozen_string_literal: true

class BaseCollection
  include Pagy::Backend

  attr_reader :params

  def initialize(relation, params)
    @relation = relation
    @params = params
  end

  def results
    @results ||= begin
      ensure_filters
      ensure_sorting
      paginate

      {
        page_info: @page_info.presence,
        records: @relation
      }
    end
  end

  private

  def filter
    @relation = yield
  end

  def ensure_sorting
    return unless params[:sort_column].present?

    sort_column = sort_columns.include?(params[:sort_column]) ? params[:sort_column] : 'created_at'
    sort_direction = %w(asc desc).include?(params[:sort_direction]) ? params[:sort_direction] : 'asc'

    filter { @relation.reorder("#{model.to_s.underscore.parameterize.underscore.pluralize}.#{sort_column} #{sort_direction}") }
  end

  def ensure_filters; end

  def sort_columns
    model.attribute_names
  end

  def paginate
    return @relation if params[:page].blank?

    @page_info, @relation = pagy(@relation, page: params[:page], items: params[:per_page])
  end

  def model
    @model ||= @relation.model
  end
end
