Rails.application.routes.draw do
  get 'nested_form/bad'
  post 'nested_form/bad'

  get 'nested_form/good'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
