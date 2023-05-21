# frozen_string_literal: true

# Create user root admin
Admin.create!(name: 'Root',
              cpf: '11122233300',
              password: 'root@123',
              photo_url: 'https://github.githubassets.com/images/modules/profile/achievements/pull-shark-default.png',
              email: 'root@root.com',
              root: true)

# Load States and Cities
filepath = ENV.fetch('FILEPATH', Rails.root.join('db/states_cities.json').to_s)
states = JSON.parse(File.read(filepath))

states.each do |state|
  state_obj = State.find_or_create_by(acronym: state['acronym'], name: state['name'])

  state['cities'].each do |city|
    City.find_or_create_by(name: city['name'], state: state_obj)
    Rails.logger.debug { "Adicionando a cidade #{city['name']} ao estado #{state_obj.name}" }
  end
end

admin_user = User.find_or_create_by(email: 'admin@rarolabs.com.br', cpf: '52947611578') do |model|
  model.attributes = {
    name: 'Admin RaroFood',
    password: '12345678'
  }
end

Administrator.find_or_create_by(user: admin_user)

state = State.find_by(acronym: 'CE')
cities = City.includes(:state).where(state: { id: state.id })

# Create User Admins
10.times do
  name = Faker::Name.name
  cpf = Faker::IDNumber.brazilian_citizen_number
  email = Faker::Internet.email
  password = Faker::Internet.password(min_length: 8)

  user = User.create!(name:, cpf:, email:, password:)
  Administrator.create!(user:)
end
administrators = Administrator.all

# Create Coupons
100.times do
  code = Faker::Alphanumeric.alpha(number: 10).upcase
  name = Faker::Commerce.product_name
  description = Faker::Lorem.paragraph
  start_date = Faker::Date.between(from: 1.year.ago, to: 1.year.from_now)
  end_date = Faker::Date.between(from: start_date, to: 1.year.from_now)
  total_discount = Faker::Number.decimal(l_digits: 2)
  creator_id = administrators.sample.id

  Coupon.create!(code:, name:, description:, start_date:, end_date:, total_discount:, creator_id:)
end

coupons = Coupon.all

# Create User Customers
20.times do
  name = Faker::Name.name
  cpf = Faker::IDNumber.brazilian_citizen_number
  email = Faker::Internet.email
  password = Faker::Internet.password(min_length: 8)

  user = User.create!(name:, cpf:, email:, password:)
  birthday = Faker::Date.birthday(min_age: 18, max_age: 65)
  customer = Customer.create!(birthday:, user:)

  address = Address.create(
    name: Faker::Address.street_suffix,
    city_id: cities.sample.id,
    public_place: Faker::Address.street_name,
    zip_code: Faker::Number.number(digits: 8).to_s,
    number: Faker::Address.building_number.to_s,
    neighborhood: Faker::Address.community,
    reference: Faker::Address.secondary_address,
    complement: Faker::Address.secondary_address,
    addressable: customer
  )

  telephone = Telephone.create(
    number: Faker::Number.number(digits: 11).to_s,
    contactable: customer
  )

  customer.addresses << address
  customer.telephones << telephone
end

customers = Customer.all

# Create User Chefs
20.times do
  name = Faker::Name.name
  cpf = Faker::IDNumber.brazilian_citizen_number
  email = Faker::Internet.email
  password = Faker::Internet.password(min_length: 8)

  user = User.create!(name:, cpf:, email:, password:)
  approver = administrators.sample
  address = Address.create(
    name: Faker::Address.street_suffix,
    city_id: cities.sample.id,
    public_place: Faker::Address.street_name,
    zip_code: Faker::Number.number(digits: 8).to_s,
    number: Faker::Address.building_number.to_s,
    neighborhood: Faker::Address.community,
    reference: Faker::Address.secondary_address,
    complement: Faker::Address.secondary_address
  )

  chef = Chef.create!(user:, approver:, address:)

  telephone = Telephone.create(
    number: Faker::Number.number(digits: 11).to_s,
    contactable: chef
  )

  chef.address = address
  chef.telephones << telephone
end

chefs = Chef.all

# Create Categories
50.times do
  name = Faker::Commerce.unique.department(max: 5)
  Category.create!(name:)
end

categories = Category.all

# Create Dishes
100.times do
  name = Faker::Food.dish
  description = Faker::Food.description
  unit_price = Faker::Number.decimal(l_digits: 2)
  chef = chefs.sample
  available = Faker::Boolean.boolean
  active = Faker::Boolean.boolean

  dish = Dish.create!(name:, description:, unit_price:, available:, active:, chef:)
  dish.categories << categories.sample(rand(1..5))
end

dishes_available = Dish.where(active: true).where(available: true)

# Create Orders
100.times do
  customer = customers.sample
  delivery_address = customer.addresses.sample
  status = 1
  freight_price = Faker::Number.decimal(l_digits: 2)
  total_price = 0
  coupon = coupons.sample

  Order.create!(customer:, delivery_address:, total_price:, freight_price:, status:, coupon:)
end

orders = Order.all

# Create Order Items
orders.each do |order|
  dish = dishes_available.sample
  amount = Faker::Number.between(from: 1, to: 5)
  unit_price = dish.unit_price

  order.total_price = (unit_price * amount) + order.freight_price

  if order.coupon.present?
    order.total_price -= order.coupon.total_discount

    order.total_price = 0 if order.total_price.negative?
  end

  OrderItem.create!(order:, dish:, amount:, unit_price:)
end

# Create Cards
100.times do
  customer = customers.sample
  number = Faker::Number.number(digits: 16).to_s
  name = Faker::Name.name
  security_code = Faker::Number.number(digits: 3)
  card_type = %w[credit debit].sample
  expiration_date = Faker::Date.between(from: 1.year.from_now, to: 5.years.from_now)

  Card.create!(customer:, number:, name:, security_code:, card_type:, expiration_date:)
end

cards = Card.all

# Create Payments
orders.each do |order|
  state = %w[pendent paid canceled].sample
  card = cards.sample
  customer = order.customer

  if customer.cards.present?
    card = customer.cards.sample
    payment_type = card.card_type
    payment_type += '_card'
  else
    payment_type = %w[pix bill].sample
  end

  Payment.create!(payment_type:, state:, order:, card:)
end
