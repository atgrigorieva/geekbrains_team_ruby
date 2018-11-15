Rails.application.routes.draw do
  
  devise_for :users#, skip: :registrations, controllers: { sessions: "sessions", passwords: "passwords" }
  # devise_for :users do 
  #   get '/users/sign_out', to: 'devise/sessions#destroy'
  # end

  root to: 'home#index'
  # Routes for get info about car
  # Машина приехала или выезжает
  patch 'ride_on_car_parking', to: "car#entry_or_leave"
  # Машина выезжает
  # patch 'car_parking', to: 'car#entry_or_leave'
  # Создание новой машины
  post 'car_create', to: 'car#create'
  post 'reservation_create', to: 'car#old_car_new_reservation'
  # Получить свободное место
  post 'get_free_place', to: 'parking#free_place'

  # Расчитать сколько необходимо заплатить за парковку
  post 'calc_amount', to: 'payment#for_booking'
  # Заплатить
  patch 'payment', to: 'payment#pay_for_reserved'

  # Открыть смену
  post 'close_cashbox', to: 'payment#open_or_close_day'
  # Закрыть смену
  post 'open_cashbox', to: 'payment#open_or_close_day'



  # Это заглушка переадресует с любого адреса на рут 
  # который не прописан выше
  get '/(:notknow)', to: 'home#index', via: [:get, :post, :patch, :delete]
end
