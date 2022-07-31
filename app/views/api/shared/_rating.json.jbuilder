json.id (@rating || rating).id
json.rating (@rating || rating).rated_as
json.created_at (@rating || rating).created_at
json.updated_at (@rating || rating).updated_at

json.user (@rating || rating).user

json.recipe (@rating || rating).recipe if defined?(show_recipe) && show_recipe
