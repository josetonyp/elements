module Elements
  module Concerns
    module CommentsActions
      extend ActiveSupport::Concern
      extend Apipie::DSL::Concern

      def self.superclass
        nil
      end

      # GET /contents
      api :GET, '/content/:content_id/comments', 'List all items from :resource'
      param :content_id, :number, :desc => "Content ID", :required => true
      def index
        respond_to do |format|
          format.json { render json: content.comments.published.all.to_json }
        end
      end


      def create
        @comment = content.comments.new(conmment_params)
        respond_to do |format|
          format.json do
            # It's necesary to reload to update the translation history
            if @comment.save && @comment.reload
              render json: @comment.json_format.to_json
            else
              render json: { errors: @comment.errors }.to_json
            end
          end
        end
      end

      private

        def content
          Elements::Content.find(params[:content_id])
        end

        # Only allow a trusted parameter "white list" through.
        def conmment_params
          params.require(:comment).permit(Elements::Comment::ATTRIBUTES)
        end
    end
  end
end
