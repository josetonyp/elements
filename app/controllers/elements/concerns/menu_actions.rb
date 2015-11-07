module Elements
  module Concerns
    module MenuActions
      extend ActiveSupport::Concern
      extend Apipie::DSL::Concern

      def self.superclass
        nil
      end

      # GET /menus
      api!
      def index
        @menus = Menu.all.map(&:format_json)
        respond_to do |format|
          format.json { render json: @menus.to_json }
        end
      end

      # GET /menus/1
      api!
      def show
        respond_to do |format|
          format.json { render json: menu.format_json.to_json }
        end
      end

      # POST /menus
      api!
      def create
        @menu = Menu.new(menu_params)
        respond_to do |format|
          format.json do
            if @menu.save
              render json: @menu.format_json.to_json
            else
              render json: { errors: @menu.errors }.to_json
            end
          end
        end
      end

      # PATCH/PUT /menus/1
      api!
      def update
        @menu = menu
        respond_to do |format|
          format.json do
            if @menu.update(menu_params)
              render json: @menu.format_json.to_json
            else
              render json: { errors: @menu.errors }.to_json
            end
          end
        end
      end

      # DELETE /menus/1
      api!
      def destroy
        menu.destroy
        respond_to do |format|
          format.json { render json: true }
        end
      end

      private

        # Use callbacks to share common setup or constraints between actions.
        def menu
          @menu = Menu.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def menu_params
          params.require(:menu).permit( Menu::ATTRIBUTES )
        end

    end
  end
end
