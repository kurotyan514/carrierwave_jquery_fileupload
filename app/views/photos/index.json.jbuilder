json.array!(@photos) do |photo|
  json.extract! photo, :id, :product_id, :images
  json.url photo_url(photo, format: :json)
end
