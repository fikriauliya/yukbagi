json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :title, :summary, :group_id, :order_no
  json.url profile_group_lesson_url(@profile, @group, lesson, format: :json)
end
