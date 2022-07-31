if @error_object.blank?
  json.rating do
    json.partial! '/api/shared/rating', show_recipe: true
  end
else
  json.error_object @error_object
end
