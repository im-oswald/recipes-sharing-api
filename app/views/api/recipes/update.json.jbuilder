if @error_object.blank?
  json.recipe do
    json.partial! 'recipe'
  end
else
  json.error_object @error_object
end
