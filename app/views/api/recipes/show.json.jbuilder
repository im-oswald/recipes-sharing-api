if @error_message.blank?
  json.recipe do
    json.partial! 'recipe', show_ingredients: true
  end
else
  json.error_message @error_message
end
