require_dependency "elements/application_controller"

module Elements
  class ChipsController < ApplicationController
    before_action :set_chip, only: [:show, :edit, :update, :destroy]

    # GET /chips
    def index
      @chips = Chip.all
    end

    # GET /chips/1
    def show
    end

    # GET /chips/new
    def new
      @chip = Chip.new
    end

    # GET /chips/1/edit
    def edit
    end

    # POST /chips
    def create
      @chip = Chip.new(chip_params)

      if @chip.save
        redirect_to @chip, notice: 'Chip was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /chips/1
    def update
      if @chip.update(chip_params)
        redirect_to @chip, notice: 'Chip was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /chips/1
    def destroy
      @chip.destroy
      redirect_to chips_url, notice: 'Chip was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_chip
        @chip = Chip.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def chip_params
        params.require(:chip).permit(:value, :key, :path, :parent_id)
      end
  end
end
