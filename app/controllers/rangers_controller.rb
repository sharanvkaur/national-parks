class RangersController < ApplicationController
  before_action :set_ranger, only: [:show, :edit, :update, :destroy]

  def index
    @rangers = Ranger.all
    p @rangers
    # Product.joins(:category).merge(Category.order(priority: :desc))
    @parks = Park.all
  end

  def show
    @parks = Park.all

  end

  def new
    @ranger = Ranger.new
    @parks = Park.all
  end

  def edit
    @parks = Park.all
  end

  def create
    @ranger = Ranger.new(ranger_params)

    if @ranger.save
      redirect_to rangers_path, notice: 'Ranger was successfully created.'
    else
      render :new
    end
  end

  def update
    if @ranger.update(ranger_params)
      redirect_to @ranger, notice: 'Ranger was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @ranger.destroy
    redirect_to rangers_path, notice: 'Ranger was successfully destroyed.'
  end


  private
    def set_ranger
      @ranger = Ranger.find(params[:id])
    end

    def ranger_params
      params.require(:ranger).permit(:name, :park_ids => [])
    end

end
