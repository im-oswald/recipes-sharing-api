if @error_message.blank?
  json.recipe do
    json.partial! 'recipe'
  end
else
  json.error_message @error_message
end
