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
              # It's necesary to reload to update the translation history
              if @content.save && @content.reload
                render json: @content.json_format.to_json
              else
                render json: { errors: @content.errors }.to_json
              end
            end
          end
      end

      # PATCH/PUT /contents/1
      def update
        I18n.locale = params['locale'].to_sym if params.has_key?('locale')
        @content = content_class.find(params[:id])
        respond_to do |format|
          format.json do
            # It's necesary to reload to update the translation history
            if @content.update(content_params) && @content.reload
              render json: @content.json_format.to_json
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

      def versions
        @content = content_class.find(params[:id])
        @content.reload
        respond_to do |format|
          format.json { render json: @content.json_format_versions.to_json }
        end
      end

      def revert
        @content = content_class.find(params[:id]).previous_version
        respond_to do |format|
          format.json do
            if @content.save && @content.reload
              render json: @content.json_format.to_json
            else
              render json: { errors: @content.errors }.to_json
            end
          end
        end
      end

      def field_versions
        @content = content_class.find(params[:id])
        @content.reload
        respond_to do |format|
          format.json { render json: @content.json_format_field_versions(params[:field]).to_json }
        end
      end

      def attachments
        @content = content_class.find(params[:id])
        respond_to do |format|
          format.json do
            render json: @content.attachments.map(&:format_json).to_json
          end
        end
      end

      def add_attachment
        @content = content_class.find(params[:id])
        @content.attachments << Attachment.find(params[:attachment_id])
        respond_to do |format|
          format.json do
            if @content.save && @content.reload
              render json: @content.attachments.map(&:format_json).to_json
            else
              render json: { errors: @content.errors }.to_json
            end
          end
        end
      end

      def remove_attachment
        @content = content_class.find(params[:id])
        @attachment = @content.attachments.find(params[:attachment_id])
        @attachment.attachable = nil
        respond_to do |format|
          format.json do
            if @attachment.save && @content.reload && @attachment.reload
              render json: @content.attachments.map(&:format_json).to_json
            else
              render json: { errors: @content.errors }.to_json
            end
          end
        end
      end

      private
        # Use callbacks to share common setup or constraints between actions.
        def content
          @content = content_class.published.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def content_params
          params.require(:content).permit(Elements::Content::ATTRIBUTES)
        end

    end
  end
end
