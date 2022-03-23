Rails.application.routes.draw do
  mount Cookpad::Performance::Engine => "/cookpad-performance"
end
