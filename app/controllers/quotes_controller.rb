class QuotesController < ApplicationController
    before_action :authenticate
    
    def list_with_tag
        response = Scraper::ListService.new(params[:tag]).run

        render json: response
    end
end
