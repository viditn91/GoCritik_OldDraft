Gocritik::Application.routes.draw do

  resources :fields

  resources :resources

  get 'admin' => 'admin#home'
  get 'admin/fields' => 'admin#fields'
  post 'fields/create_collection' => 'fields#create_collection'
end
