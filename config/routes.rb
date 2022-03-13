Rails.application.routes.draw do
  get '/quotes/:tag', to: 'quotes#list_with_tag'
end
