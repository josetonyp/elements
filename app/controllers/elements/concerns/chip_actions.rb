module Elements
  module Concerns
    module ChipActions
      extend ActiveSupport::Concern
      extend Apipie::DSL::Concern

      def self.superclass
        nil
      end

      # GET /menus
      api :GET, '/chips', 'List all items from Chip'
      def index
        @chips = Chip.all.map(&:format_json)
        respond_to do |format|
          format.json { render json: @chips.to_json }
        end
      end

      # GET /chips/1
      api!
      param :id, :number, :desc => "Chip ID", :required => true
      def show
        respond_to do |format|
          format.json { render json: chip.to_json }
        end
      end

      # POST /chips
      api!
      def create
        @chip = Chip.new(chip_params)
        respond_to do |format|
          format.json do
            if @chip.save
              render json: @chip.to_json
            else
              render json: { errors: @chip.errors }.to_json
            end
          end
        end
      end

      # PATCH/PUT /chips/1
      api!
      def update
        @chip = chip
        chip_params_filtered = chip_params
        chip_params_filtered.delete('key')
        respond_to do |format|
          format.json do
            if @chip.update(chip_params_filtered)
              render json: @chip.to_json
            else
              render json: { errors: @chip.errors }.to_json
            end
          end
        end
      end

      # DELETE /chips/1
      api :DELETE, '/chips/:id', 'Deletes given Chip'
      param :id, Integer, :desc => "Chip ID", :required => true
      def destroy
        chip.destroy
        respond_to do |format|
          format.json { render json: true }
        end
      end



      private
        # Use callbacks to share common setup or constraints between actions.
        def chip
          @chip = Chip.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def chip_params
          params.require(:chip).permit(Chip::ATTRIBUTES)
        end

    end
  end
end
