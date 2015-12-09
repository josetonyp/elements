module Elements
  module Concerns
    module ContentActions
      extend ActiveSupport::Concern
      extend Apipie::DSL::Concern

      def self.superclass
        nil
      end

      def content_class
        Elements::Content
      end

      # GET /contents
      api :GET, '/:controller_path', 'List all items from :resource'
      def index
        respond_to do |format|
          format.json { render json: content_class.published.all.to_json }
        end
      end

      # GET /contents/1
      api :GET, '/:controller_path/:id', 'Show one :resource'
      param :id, :number, :desc => ":resource ID", :required => true
      def show
        respond_to do |format|
          format.json { render json: content.to_json }
        end
      end

      # POST /contents
      api :POST, '/:controller_path', 'Creates a new :resource'
      param :locale, String,
        meta: { example: 'en' }, desc: "Locale in which given :resource will be created"
      param ':resource', Hash do
        param :path, String, required: true, desc: "Path to find given :resource from url"
        param :name, String, required: true, desc: ":resource name"
        param :value, [true, false], required: true, desc: ":resource content normally the HTML content"
        param :excerpt, String, desc: ":resource short version of value"

        param :multiline, [true, false], dafault: false
        param :position, Integer
        param :template, String

        param :meta_title, String
        param :meta_description, String
        param :meta_keyword, String

        param :status, String, desc: 'Status holder'
        param :publish_at, String, required: true, desc: "Must be formated in the following formats", meta: { formats: { iso8601: DateTime.now.iso8601, rfc2822: DateTime.now.rfc2822, rfc3339: DateTime.now.rfc3339, rfc822: DateTime.now.rfc822 } }
        param :latitude, Float
        param :longitude, Float
      end
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
      api :PUT, '/:controller_path/:id', 'Update given :resource'
      param :id, :number, :desc => ":resource ID", :required => true
      param :locale, String, meta: { example: "en" }, desc: "Locale in which given :resource will be created"
      param ':resource', Hash do
        param :path, String, required: true, desc: "Path to find given :resource from url"
        param :name, String, required: true, desc: ":resource name"
        param :value, [true, false], required: true, desc: ":resource content normally the HTML content"
        param :excerpt, String, desc: ":resource short version of value"

        param :multiline, [true, false], dafault: false
        param :position, Integer
        param :template, String

        param :meta_title, String
        param :meta_description, String
        param :meta_keyword, String

        param :status, String, desc: 'Status holder'
        param :publish_at, String, required: true, desc: "Must be formated in the following formats", meta: { formats: { iso8601: DateTime.now.iso8601, rfc2822: DateTime.now.rfc2822, rfc3339: DateTime.now.rfc3339, rfc822: DateTime.now.rfc822 } }
        param :latitude, Float
        param :longitude, Float
      end
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
      api :DELETE, '/:controller_path/:id', 'Deletes given :resource'
      param :id, :number, :desc => ":resource ID", :required => true
      def destroy
        content_class.find(params[:id]).destroy
        respond_to do |format|
          format.json { render json: true }
        end
      end

      api :GET, '/:controller_path/:id/versions', 'Show all versions for given :resource'
      param :id, :number, :desc => ":resource ID", :required => true
      def versions
        @content = content_class.find(params[:id])
        @content.reload
        respond_to do |format|
          format.json { render json: @content.json_format_versions.to_json }
        end
      end

      api :PUT, '/:controller_path/:id/revert', 'Revert given :resource to previous version'
      param :id, :number, :desc => ":resource ID", :required => true
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

      api :GET, '/:controller_path/:id/field_versions', 'Show all versions for given :resource field'
      param :id, :number, :desc => ":resource ID", :required => true
      def field_versions
        @content = content_class.find(params[:id])
        @content.reload
        respond_to do |format|
          format.json { render json: @content.json_format_field_versions(params[:field]).to_json }
        end
      end

      api :GET, '/:controller_path/:id/attachments', 'Show all attachments for given :resource field'
      param :id, :number, :desc => ":resource ID", :required => true
      def attachments
        @content = content_class.find(params[:id])
        respond_to do |format|
          format.json do
            render json: @content.attachments.map(&:format_json).to_json
          end
        end
      end

      api :PUT, '/:controller_path/:id/add_attachment', 'Adds an attachment to give :resource'
      param :id, :number, :desc => ":resource ID", :required => true
      param :attachment_id, Integer, :desc => "Attachment ID", :required => true
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

      api :PUT, '/:controller_path/:id/remove_attachment', 'Removes an attachment from give :resource'
      param :id, :number, :desc => ":resource ID", :required => true
      param :attachment_id, Integer, :desc => "Attachment ID", :required => true
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
