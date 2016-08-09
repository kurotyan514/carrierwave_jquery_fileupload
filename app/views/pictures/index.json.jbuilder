json.array!(@pictures) do |picture|
  json.extract! picture, :id, :gallery_id, :image
  json.url picture_url(picture, format: :json)
end
