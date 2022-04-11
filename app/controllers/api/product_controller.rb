module Api
  class ProductController < ApplicationController
    respond_to :json

    def all
    end

    def default_serializer_options
      { root: false }
    end
  end
end
