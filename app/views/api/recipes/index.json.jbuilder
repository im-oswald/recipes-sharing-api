if @recipes.present?
  json.recipes do
    json.array! @recipes, partial: 'recipe', as: :recipe
  end
else
  json.error_message @error_message
end
