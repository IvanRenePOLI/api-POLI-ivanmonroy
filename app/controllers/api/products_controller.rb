module Api
  class ProductsController < ApplicationController
    include RenderHelper
    before_action :set_product, only: [:show, :edit, :update, :destroy, :get_comments ], raise: false
    skip_before_action :authenticate_user!, only: [:create], raise: false
    respond_to :json

    def all
    end

    def default_serializer_options
      { root: false }
    end

    def index
      @products = Product.all
      render_default_format(@products, true, 200)
    end

    def show
      render_default_format(@product,true,200)
    rescue Exception => e
      puts e.inspect
    end

    def get_by_desc
      @products = Product.where("UPPER(name) LIKE ? OR UPPER(description) LIKE ? ", "#{params[:filter].upcase}%", "#{params[:filter].upcase}%")
      render_default_format(@products,true,200)
    rescue Exception => e
      render_default_error e, 401
    end

    def get_comments
      render_default_format({product: @product, averange: @product.get_average_start, comments: @product.comment_products.joins(:client).pluck('comment_products.id, comment_products.comment, comment_products.star,  clients.name, clients.email') } ,true,200)
    rescue Exception => e
      puts e.inspect
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find_by(id: params[:id])
    rescue Exception => e
      render_default_error e, 401
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.permit(:name, :description, :price, :color, :available, :brand, :image)
    end
  end
end
