if @error_message.blank?
  json.rating do
    json.partial! '/api/shared/rating', show_recipe: true
  end
else
  json.error_message @error_message
end
