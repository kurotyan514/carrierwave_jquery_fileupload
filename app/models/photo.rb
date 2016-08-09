class Photo < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :product
  serialize :images
  mount_uploaders :images , ImageUploader

 # 上傳完圖片後得預覽圖，傳給template-upload需要的json
  def to_jq_upload(product)
    json_data = {}
    self.images.each_with_index do|image,index|
      image_data =   {
          "name" => image.file.filename,
          "size" => image.size,
          "url" => image.url,
          "thumbnailUrl" => image.thumb.url,
          # "myIndex" => index,
          "deleteUrl" => remove_image_at_index_product_photo_path(product,self,index:index),
          "deleteType" => "POST"

        }
        json_data[index] = image_data

    end

    return json_data

  end

end
