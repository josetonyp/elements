require_dependency "elements/application_controller"

module Elements
  class ContentsController < ApplicationController
    before_action :set_content, only: [:show, :edit, :update, :destroy]

    # GET /contents
    def index
      @contents = Content.all
      respond_to do |format|
        format.json { render json: @contents.to_json }
      end
    end

    # GET /contents/1
    def show
      respond_to do |format|
        format.json { render json: @content.to_json }
      end
    end

    # POST /contents
    def create
      @content = Content.new(content_params)

      if @content.save
        respond_to do |format|
          format.json { render json: @content.to_json }
        end
      else
        render :new
      end
    end

    # PATCH/PUT /contents/1
    def update
      I18n.locale = params['locale'].to_sym
      if @content.update(content_params)
        respond_to do |format|
          format.json { render json: @content.to_json }
        end
      else
        render :edit
      end
    end

    # DELETE /contents/1
    def destroy
      @content.destroy
      redirect_to contents_url, notice: 'Content was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_content
        @content = Content.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def content_params
        params.require(:content).permit(:name, :value)
      end
  end
end
