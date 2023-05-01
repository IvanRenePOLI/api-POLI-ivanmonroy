module Api
  class ClientsController < ApplicationController
    include RenderHelper
    before_action :set_client, only: [:show, :edit, :update, :destroy], raise: false
    skip_before_action :authenticate_user!, only: [:create], raise: false
    respond_to :json

    def index
      @clients = Client.all
      render_default_format(@clients, true, 200)
    end

    def show
      render_default_format(@client,true,200)
    rescue Exception => e
      puts e.inspect
    end

    def create
      @client = Client.new(params)
      puts params
        if @client.save
          render_success_format('Su comentario ha sido registrado correctamente', @client, true)
        end
    rescue Exception => e
      render_default_error e, 401
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_client
      @client = Client.find_by(id: params[:id])
    rescue Exception => e
      render_default_error e, 401
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def client_params
      params.permit(:name, :email)
    end

  end
end
