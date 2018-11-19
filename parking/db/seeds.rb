def drop_all_tables 
  [HistoryOfCashbox,CashBoxOperation, HistoryReservation,HistoryEntry,Car,ParkingPlace,Rate,RateInterval, Operator,Parking,Owner,
    User,Role,
    CashBoxMoment].each do | klass |
      print "Очищаем таблицу #{klass}#{" "*30}\r"
      klass.delete_all
    end
end
begin
  
  drop_all_tables


  N = 200

  Role.create(id: 1, name: "operator")
  Role.create(id: 2, name: "owner")

  users = N.times.map do | i |
    print "Заполняем пользователя № #{i}\r"
    print "Заполняем пользователя № #{i}#{" "*30}\r"
    login = FFaker::Internet.user_name
    {
      id: i,
      email: FFaker::Internet.email,
      role: Role.all.sample,
      login: login,
      password: 'password'
    }
  end
  print "Создаем пользователей#{" "*30}\r"
  User.create! users

  owners = User.all.where(:role_id => 2).each_with_index.map do |user, inx|
    print "Заполняем владельца № #{inx}#{" "*30}\r"
    {
      id: inx,
      user: user,
      first_name: FFaker::NameRU.first_name,
      last_name: FFaker::NameRU.last_name,
      second_name: FFaker::NameRU.patronymic,
    }
  end
  print "Создаем  пользователей#{" "*30}\r"
  Owner.create! owners

  parkings = N.times.map do |i|
    print "Заполняем парковки № #{i}#{" "*30}\r"
    {
      id: i,
      owner: Owner.all.sample,
      number_of_places: rand(2..8),
      name: FFaker::AddressRU.street_address,
    }
  end
  print "Создаем парковки#{" "*30}\r"
  Parking.create! parkings

  parking_places = N.times.map do |id_parking|
    parking = Parking.find(id_parking)
    print "Заполняем парковочные места для парковки № #{id_parking}#{" "*30}\r"
    parking.number_of_places.times.map do |num_place|
      {
        parking: parking,
        number: num_place,
        busy: false
      }
    end
  end
  print "Создаем парковочные места#{" "*30}\r"
  ParkingPlace.create! parking_places

  operators = User.all.where(:role_id => 1).each_with_index.map do |user, inx|
    print "Заполняем оператора № #{inx}#{" "*30}\r"
    {
      id: inx,
      user: user,
      name: FFaker::NameRU.name,
      parking: Parking.all.sample
    }
  end
  print "Создаем операторов #{" "*30}\r"
  Operator.create! operators



  RateInterval.create(id: 1, :name => "Месяц")
  RateInterval.create(id: 2, :name => "День")
  RateInterval.create(id: 3, :name => "Час")

  month_rate = Parking.all.each.map do |parking|
    print "Заполяем тарифы для парковки № #{parking.id}#{" "*30}\r"
    {
      name: "Помесячная",
      parking: parking,
      rate_interval: RateInterval.find(1),
      price: rand(1000.00..3000.00).round(2),
      date_from: Time.now,
      date_to: Time.new(9999,1,1,1,1),

    }
  end
  day_rate = Parking.all.each.map do |parking|
    print "Заполяем тарифы для парковки № #{parking.id}#{" "*30}\r"
    {
      name: "Ежедневная",
      parking: parking,
      rate_interval: RateInterval.find(2),
      price: (rand(200.00..500.00).round(2)),
      date_from: Time.now(),
      date_to: Time.new(9999,1,1,1,1),
    }
  end
  hour_rate = Parking.all.each.map do |parking|
    print "Заполяем тарифы для парковки № #{parking.id}#{" "*30}\r"
    {
      name: "Час",
      parking: parking,
      rate_interval: RateInterval.find(3),
      price: (rand(50.00..200.00).round(2)),
      date_from: Time.now(),
      date_to: Time.new(9999,1,1,1,1,1)
    }
  end

  [hour_rate, day_rate, hour_rate].each do | el |
    print "Сохраняем тарифы для парковок#{" "*30}\r"
    Rate.create! el
  end


test_user_operator = User.create! :id => 9000, :login => "operator", :password => "operator", :password_confirmation => "operator", :role => Role.first
Operator.create! :id => 9000, :user => test_user_operator, :parking => Parking.first, :name => "Иван Иванович"

test_user_owner = User.create! :id => 9001, :login => "Owner", :password => "ownerr", :password_confirmation => "ownerr", :role => Role.second
Owner.create! :id => 9000, :user => test_user_owner, :first_name => "Владимир", :last_name => "Путин", :second_name => "Владимирович"


rescue => exception
  puts "Внимание! Во время заполнения произошла ошибка #{exception.message}. Таблицы будут очищены."
  drop_all_tables
else
  puts "База данных заполненна#{" "*30}\n"
  puts 'Обновляем подключения к таблицам'
  ActiveRecord::Base.connection.tables.each { |t|     ActiveRecord::Base.connection.reset_pk_sequence!(t) }
end


