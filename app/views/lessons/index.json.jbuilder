json.array!(@lessons) do |lesson|
  json.extract! lesson, :id, :title, :summary, :group_id, :order_no, :external_url, :type, :provider_name, :favicon_url, :description, :thumbnail_url
  json.url profile_group_lesson_url(@profile, @group, lesson, format: :json)
  json.html_url profile_group_lesson_url(@profile, @group, lesson)
end