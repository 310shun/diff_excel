json.array!(@todos) do |todo|
  json.extract! todo, :todo, :due
  json.url todo_url(todo, format: :json)
end