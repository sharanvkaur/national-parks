class ParksController < ApplicationController
    before_action :set_park, only: [:show, :edit, :update, :destroy]

  def index
    @parks = Park.all
  end

  def show
  end

  def new
    @park = Park.new
  end

  def edit
  end

  # POST /parks
  def create
    # new park is assigned to current_user
    @park = Park.new(park_params)

    upload_file
    if @park.save
      delete_old_file
      redirect_to @park, notice: 'Park was successfully created.'
    else
      render :new
    end
  end


  def update
    upload_file
    if @park.update(park_params)
      delete_old_file
      redirect_to @park, notice: 'Park was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    delete_old_file @park.picture
    @park.destroy
    redirect_to parks_url, notice: 'Park was successfully destroyed.'
  end

  private
    def set_park
      @park = Park.find(params[:id])
    end

    def park_params
      params.require(:park).permit(:name, :description, :picture)
    end

    def upload_file
      if params[:park][:picture].present?
        if @park.valid?
          uploaded_file = params[:park][:picture].path
          cloudnary_file = Cloudinary::Uploader.upload(uploaded_file)
          @old_file = @park.picture
          @park.picture = cloudnary_file['public_id']
        end
        params[:park].delete :picture
      end
    end

  def delete_old_file old_file = nil
    file_to_del = old_file || @old_file
    Cloudinary::Uploader.destroy(file_to_del, :invalidate => true) unless file_to_del.blank?
  end

end
