class PicturesController < ApplicationController
  before_action :set_picture, only: [:show, :edit, :update, :destroy]

  # GET /pictures
  # GET /pictures.json
  def index
    @gallery = Gallery.find(params[:gallery_id])
    @pictures = @gallery.pictures
  end

  # GET /pictures/1
  # GET /pictures/1.json
  def show
    @gallery = Gallery.find(params[:gallery_id])
  end

  # GET /pictures/new
  def new
    @gallery = Gallery.find(params[:gallery_id])
    @picture = @gallery.pictures.build
  end

  # GET /pictures/1/edit
  def edit
    @gallery = Gallery.find(params[:gallery_id])
  end

  # POST /pictures
  # POST /pictures.json
  def create
    @gallery = Gallery.find(params[:gallery_id])
    @picture = @gallery.pictures.build(picture_params)

    respond_to do |format|
      if @picture.save
      format.json { render json: {files: [@picture.to_jq_upload(@gallery)] }}
      # if @picture.save
      #   format.html { redirect_to gallery_picture_path(@gallery,@picture), notice: 'Picture was successfully created.' }
      #   format.json { render :show, status: :created, location: @picture }
      # else
      #   format.html { render :new }
      #   format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pictures/1
  # PATCH/PUT /pictures/1.json
  def update
    @gallery = Gallery.find(params[:gallery_id])
    respond_to do |format|
      if @picture.update(picture_params)
        format.html { redirect_to gallery_picture_path(@gallery,@picture), notice: 'Picture was successfully updated.' }
        format.json { render :show, status: :ok, location: @picture }
      else
        format.html { render :edit }
        format.json { render json: @picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pictures/1
  # DELETE /pictures/1.json
  def destroy
    @gallery = Gallery.find(params[:gallery_id])
    @picture = @gallery.pictures.find(params[:id])
    @picture.destroy
    respond_to do |format|
      format.html { redirect_to gallery_pictures_path(@gallery), notice: 'Picture was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_picture
      @picture = Picture.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def picture_params
      params.require(:picture).permit(:gallery_id, {images:[]})
    end
end
