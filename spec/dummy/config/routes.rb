Rails.application.routes.draw do
  mount Platforms::Core::Engine => "/platforms-core"
end
