module Elements
  module Concerns
    module AttachmentActions
      extend ActiveSupport::Concern
      extend Apipie::DSL::Concern

      def self.superclass
        nil
      end

      def content_class
        Elements::Attachment
      end

      # GET /attachments
      api :GET, '/:controller_path', 'List all items from :resource'
      def index
        @attachments = content_class.all.map(&:format_json)
        respond_to do |format|
          format.json { render json: @attachments.to_json }
        end
      end

      # GET /attachments/1
      api :GET, '/:controller_path/:id', 'Show one :resource'
      param :id, :number, :desc => ":resource ID", :required => true
      def show
        respond_to do |format|
          format.json { render json: attachment.format_json.to_json }
        end
      end

      # POST /attachments
      api!
      def create
        @attachment = content_class.new(attachment_params)
        respond_to do |format|
          format.json do
            if @attachment.save
              render json: @attachment.to_json
            else
              render json: { errors: @attachment.errors }.to_json
            end
          end
        end
      end

      # PATCH/PUT /attachments/1
      api!
      def update
        @attachment = attachment
        respond_to do |format|
          format.json do
            if @attachment.update(attachment_params)
              render json: @attachment.to_json
            else
              render json: { errors: @attachment.errors }.to_json
            end
          end
        end
      end

      # DELETE /attachments/1
      api!
      def destroy
        attachment.destroy
        respond_to do |format|
          format.json { render json: true }
        end
      end

      private

        # Use callbacks to share common setup or constraints between actions.
        def attachment
          @attachment = content_class.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def attachment_params
          params.require(:attachment).permit( Attachment::ATTRIBUTES )
        end

    end
  end
end
