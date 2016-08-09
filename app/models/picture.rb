class Picture < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :gallery
  serialize :images
  mount_uploaders :images , ImageUploader

  # 上傳完圖片後得預覽圖，傳給template-upload需要的json
  def to_jq_upload(gallery)
    json_data = {}
    self.images.each_with_index do|image,index|
      image_data =   {
          "name" => image.file.filename,
          "size" => image.size,
          "url" => image.url,
          "thumbnailUrl" => image.thumb.url,
          "deleteUrl" => gallery_picture_path(gallery,self),
          "deleteType" => "DELETE"
        }
        json_data[index] = image_data

    end

    return json_data

  end
end
