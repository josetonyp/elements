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
          format.json { render json: filtered_comments.all.to_json }
        end
      end

      # POST /contents
      api :POST, '/content/:content_id/comments', 'Creates a new :resource'
      param :locale, String,
        meta: { example: 'en' }, desc: "Locale in which given :resource will be created"
      param ':resource', Hash do
        param :text, String, required: true, desc: "Comment text"
        param :parent_id, Integer
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

      # POST /contents
      api :PUT, '/content/:content_id/comments/:id', 'Publish a :resource'
      def publish
        @comment = comment
        respond_to do |format|
          format.json do
            if @comment.publish!
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

        def comment
          Elements::Comment.find(params[:id])
        end

        def find_filter
          params[:filter] if ['published'].include?(params[:filter])
        end

        def filtered_comments
          if find_filter
            content.comments.send(find_filter)
          else
            content.comments
          end
        end

        # Only allow a trusted parameter "white list" through.
        def conmment_params
          params.require(:comment).permit(Elements::Comment::ATTRIBUTES)
        end
    end
  end
end
