module Elements
  module Concerns
    module ContentActions
      extend ActiveSupport::Concern

      def content_class
        Content
      end

      # GET /contents
      def index
        respond_to do |format|
          format.json { render json: content_class.published.all.to_json }
        end
      end

      # GET /contents/1
      def show
        respond_to do |format|
          format.json { render json: content.to_json }
        end
      end

      # POST /contents
      def create
        @content = content_class.new(content_params)
          respond_to do |format|
            format.json do
              if @content.save
                render json: @content.to_json
              else
                render json: { errors: @content.errors }.to_json
              end
            end
          end
      end

      # PATCH/PUT /contents/1
      def update
        I18n.locale = ['locale'].to_sym if params.has_key?('locale')
        @content = content_class.find(params[:id])
        respond_to do |format|
          format.json do
            if @content.update(content_params)
              render json: @content.to_json
            else
              render json: { errors: @content.errors }.to_json
            end
          end
        end
      end

      # DELETE /contents/1
      def destroy
        content_class.find(params[:id]).destroy
        respond_to do |format|
          format.json { render json: true }
        end
      end


      # Use callbacks to share common setup or constraints between actions.
      def content
        @content = content_class.published.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def content_params
        allowed = [:name, :value, :multiline, :position, :creator_id, :updater_id, :title, :meta_title, :meta_description, :meta_keyword, :excerpt, :status, :publish_at, :latitude, :longitude]
        params.require(:content).permit(allowed)
      end

    end
  end
end
