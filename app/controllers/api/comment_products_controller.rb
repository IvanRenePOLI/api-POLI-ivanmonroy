module Api
  class CommentProductsController < ApplicationController
    include RenderHelper
    before_action :set_comment, only: [:show, :edit, :update, :destroy], raise: false
    skip_before_action :authenticate_user!, only: [:create], raise: false
    respond_to :json

    def index
      @comment_products = CommentProduct.all
      render_default_format(@comment_products, true, 200)
    end

    def show
      render_default_format(@product,true,200)
    rescue Exception => e
      puts e.inspect
    end

    def create
      unless Client.exists?(:email => params[:email])
        @client = Client.new(:email => params[:email], :name => params[:name])
        @client.save
      end

      @client = Client.where('email = ?', params[:email]).first
      puts @client

      @comment_product = CommentProduct.create(:comment => params[:comment], :star => params[:star] , :client_id => @client.id , :product_id => params[:product_id] )
      puts params
        if @comment_product.save
          render_success_format('Su comentario ha sido registrado correctamente', @comment_product, true)
        end
    rescue Exception => e
      render_default_error e, 401
    end

    def get_by_product
      @product = CommentProduct.find_by(product_id: params[:product_id])
      render_default_format(@product,true,200)
    rescue Exception => e
      render_default_error e, 401
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @product = CommentProduct.find_by(id: params[:id])
    rescue Exception => e
      render_default_error e, 401
    end

    # Never trust parameters from the scary internet, only allow the white list through.


  end
end
