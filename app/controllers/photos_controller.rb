class PhotosController < ApplicationController
  before_action :set_photo, only: [:show, :edit, :update, :destroy]

  # GET /photos
  # GET /photos.json
  def index
    @product = Product.find(params[:product_id])
    @photo = @product.photo
  end

  # GET /photos/1
  # GET /photos/1.json
  def show
  end

  # GET /photos/new
  def new
    @product = Product.find(params[:product_id])
    @photo = @product.build_photo
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = add_more_images(photo_params[:images])
    respond_to do |format|
      if @photo.save
         format.json { render json: {files: [@photo.to_jq_upload(@product)] }}
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update

  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to product_photos_path(@product), notice: 'Photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def add_more_images(new_images)
    @product = Product.find(params[:product_id])
    @photo = @product.photo
    if @photo.nil?
      @photo = @product.build_photo
    end
    images = @photo.images
    images += new_images
    @photo.images = images
    return @photo
   end

  def remove_image_at_index
    @product = Product.find(params[:product_id])
    @photo = @product.photo
    remain_images = @photo.images # copy the array
    deleted_image = remain_images.delete_at(params[:index].to_i) # delete the target image
    deleted_image.try(:remove!) # delete image from S3
    @photo.images = remain_images # re-assign back
    @photo.save
    render json:true
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @product = Product.find(params[:product_id])
      @photo = @product.photo
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
      params.require(:photo).permit(:product_id, {images:[]})
    end
end
