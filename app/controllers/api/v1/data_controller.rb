module Api::V1
  class DataController < ApplicationController
    before_action :data_params
    def process_data
      file_data = DataServices::FileService.new(params[:file])
      processed = file_data.call
      if processed
        render json: { message: "File processed successfully" }, status: :ok
      else
        render json: { error: processed[:error] }, status: :unprocessable_entity
      end

    rescue StandardError => e
      render json: { error: e.message }, status: :unprocessable_entity
    end

    private

    def data_params
      params.permit(:file)
    end
  end
end