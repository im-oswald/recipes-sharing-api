json.id (@recipe || recipe).id
json.created_at (@recipe || recipe).created_at
json.updated_at (@recipe || recipe).updated_at
json.title (@recipe || recipe).title
json.descriptions (@recipe || recipe).descriptions
json.time (@recipe || recipe).time
json.difficulty (@recipe || recipe).difficulty
json.category_id (@recipe || recipe).category_id

json.ingredients (@recipe || recipe).ingredients do |ingredient|
  json.id ingredient.id
  json.created_at ingredient.created_at
  json.updated_at ingredient.updated_at
  json.unit ingredient.unit
  json.amount ingredient.amount
  json.recipe_id ingredient.recipe_id
end if defined?(show_ingredients) && show_ingredients

json.ratings do
  json.array! (@recipe || recipe).ratings, partial: '/api/shared/rating', as: :rating
end

json.user_id (@recipe || recipe).user_id
