json.array!(@groups) do |group|
  json.extract! group, :id, :user_id, :name, :category, :ordered
  json.url profile_group_url(@profile, group, format: :json)
end
