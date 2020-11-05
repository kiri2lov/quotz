Rails.application.routes.draw do
  resource 'admin', controller: 'admin', only: [:show, :create]
  root 'welcome#index'
end
