json.array!(@courses) do |course|
  json.extract! course, :id, :title, :description, :start_date, :end_date, :user_id, :status
  json.url course_url(course, format: :json)
end
