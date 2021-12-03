class ApplicationController < ActionController::API

    def authenticate
        token = request.headers["Authorization"]

        unless token == "238d4793-70de-4183-9707-48ed8ecd19d9"
            head :forbidden
        end
    end
end
