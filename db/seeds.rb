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
50.times do
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

  3.times do
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

dishes_seed = {
  'Spaghetti' => %w[Italian Pasta],
  'Burger' => ['American', 'Fast Food', 'Beef'],
  'Sushi' => %w[Japanese Seafood Rice],
  'Tacos' => ['Mexican', 'Street Food', 'Beef'],
  'Pizza' => %w[Italian Cheese Bread],
  'Curry' => %w[Indian Spicy Rice],
  'Salad' => %w[Healthy Vegetarian Fresh],
  'Ramen' => %w[Japanese Noodles Soup],
  'Steak' => %w[American Beef Grilled],
  'Pasta' => ['Italian', 'Tomato Sauce', 'Cheese'],
  'Sushi Rolls' => %w[Japanese Seafood Raw],
  'Fried Chicken' => ['American', 'Fast Food', 'Chicken'],
  'Fish and Chips' => %w[British Seafood Fried],
  'Pad Thai' => %w[Thai Noodles Spicy],
  'Pho' => %w[Vietnamese Soup Beef],
  'Lasagna' => %w[Italian Pasta Cheese],
  'Sandwich' => %w[American Bread Lunch],
  'Dumplings' => %w[Chinese Steamed Pork],
  'Shawarma' => ['Middle Eastern', 'Meat', 'Wrap'],
  'Fajitas' => %w[Mexican Grilled Chicken],
  'Sashimi' => %w[Japanese Seafood Raw],
  'Tandoori Chicken' => %w[Indian Spicy Grilled],
  'Gyros' => %w[Greek Meat Pita],
  'Pancakes' => %w[American Breakfast Sweet],
  'Poke Bowl' => %w[Hawaiian Seafood Rice],
  'Philly Cheesesteak' => %w[American Beef Cheese],
  'Ceviche' => %w[Peruvian Seafood Citrus],
  'Ravioli' => %w[Italian Pasta Cheese],
  'Dim Sum' => %w[Chinese Steamed Dumplings],
  'Goulash' => %w[Hungarian Stew Beef],
  'Biryani' => %w[Indian Rice Spicy],
  'Miso Soup' => %w[Japanese Soup Tofu],
  'Falafel' => ['Middle Eastern', 'Vegetarian', 'Chickpeas'],
  'Crab Cakes' => %w[American Seafood Appetizer],
  'Crepes' => %w[French Dessert Sweet],
  'Philly Roll' => ['Sushi', 'Seafood', 'Cream Cheese'],
  'Tacos al Pastor' => ['Mexican', 'Street Food', 'Pork'],
  'Carbonara' => %w[Italian Pasta Egg],
  'Hamburger' => %w[American Beef Bun],
  'Chow Mein' => %w[Chinese Noodles Stir-Fry],
  'Chicken Tikka Masala' => %w[Indian Spicy Chicken],
  'Cobb Salad' => %w[American Salad Bacon],
  'Sushi Burrito' => %w[Japanese Sushi Wrap],
  'Tom Yum Soup' => %w[Thai Soup Spicy],
  'Cannoli' => %w[Italian Dessert Pastry],
  'Fish Tacos' => %w[Mexican Seafood Tortilla],
  'Ratatouille' => %w[French Vegetarian Stew],
  'Chicken and Waffles' => %w[American Chicken Breakfast],
  'Tiramisu' => %w[Italian Dessert Coffee],
  'Donuts' => %w[American Dessert Fried],
  'Hummus' => ['Middle Eastern', 'Appetizer', 'Chickpeas'],
  'Peking Duck' => %w[Chinese Duck Roasted],
  'Chicken Parmesan' => %w[Italian Chicken Cheese],
  'Moussaka' => %w[Greek Eggplant Baked],
  'Gazpacho' => %w[Spanish Soup Cold],
  'Chicken Satay' => %w[Thai Chicken Skewers],
  'Couscous' => %w[Moroccan Grains Vegetables],
  'Beef Stroganoff' => %w[Russian Beef Creamy],
  'Pierogi' => %w[Polish Dumplings Potato],
  'Baklava' => %w[Greek Dessert Nuts],
  'Croissant' => %w[French Breakfast Pastry],
  'Chicken Adobo' => %w[Filipino Chicken Vinegar],
  'Poutine' => ['Canadian', 'Fries', 'Cheese Curds'],
  'Guacamole' => %w[Mexican Dip Avocado],
  'Shrimp and Grits' => %w[American Seafood Grits],
  'Baba Ganoush' => ['Middle Eastern', 'Eggplant', 'Dip'],
  'Beef Wellington' => %w[British Beef Pastry],
  'Beignets' => %w[French Dessert Fried],
  'Egg Rolls' => %w[Chinese Fried Vegetables],
  'Fish Chowder' => ['New England', 'Seafood', 'Soup'],
  'Ginger Beef' => %w[Canadian Beef Stir-Fry],
  'Greek Salad' => %w[Greek Salad Feta],
  'Gumbo' => %w[Louisiana Stew Sausage],
  'Hot Pot' => %w[Chinese Soup Meat],
  'Kebab' => ['Middle Eastern', 'Grilled', 'Meat'],
  'Macaroni and Cheese' => %w[American Cheese Pasta],
  'Mango Sticky Rice' => %w[Thai Dessert Mango],
  'Paella' => %w[Spanish Rice Seafood],
  'Potato Pancakes' => %w[Polish Potato Breakfast],
  'Red Curry' => %w[Thai Curry Spicy],
  'Samosas' => %w[Indian Appetizer Pastry],
  'Scotch Eggs' => %w[British Egg Sausage],
  'Shrimp Scampi' => %w[Italian Seafood Garlic],
  'Sushi Pizza' => %w[Japanese Sushi Crust],
  'Tikka Masala' => %w[Indian Curry Creamy],
  'Tonkatsu' => %w[Japanese Pork Breaded],
  'Tzatziki' => %w[Greek Dip Yogurt],
  'Veggie Wrap' => %w[Vegetarian Wrap Vegetables],
  'Wonton Soup' => %w[Chinese Soup Dumplings],
  'Yakitori' => %w[Japanese Skewers Grilled],
  'Zucchini Bread' => ['Baked Goods', 'Bread', 'Zucchini']
}

chefs = Chef.all

dishes_seed.each do |dish, categories|
  name = dish
  content = Faker::Food.description
  unit_price = Faker::Number.decimal(l_digits: 2)
  chef = chefs.sample
  available = Faker::Boolean.boolean
  active = Faker::Boolean.boolean

  new_dish = Dish.create!(name:, content:, unit_price:, available:, active:, chef:)

  # Add cover_image field
  file = "#{rand(1..26)}.jpg"
  cover_image_path = "db/foods/#{file}"
  new_dish.cover_image.attach(io: File.open(cover_image_path), filename: file)

  if new_dish.save
    categories.each do |category_name|
      category = Category.find_or_create_by(name: category_name)
      new_dish.categories << category
    end
  else
    Rails.logger.debug { "Error saving dish: #{new_dish.errors.full_messages.join(', ')}" }
  end
end

dishes_available = Dish.where(active: true).where(available: true)

# Create Orders
100.times do
  customer = customers.sample
  delivery_address = customer.addresses.sample
  status = Order.statuses.keys.sample
  freight_price = Faker::Number.decimal(l_digits: 2)
  total_price = 0
  coupon = coupons.sample

  order = Order.new(
    customer:,
    delivery_address:,
    total_price:,
    freight_price:,
    status:,
    coupon:
  )

  dish = dishes_available.sample
  amount = Faker::Number.between(from: 1, to: 5)
  unit_price = dish.unit_price
  order.total_price = (unit_price * amount) + order.freight_price

  if order.coupon.present?
    order.total_price -= order.coupon.total_discount

    order.total_price = 0 if order.total_price.negative?
  end

  order_item = order.items.build(
    dish:,
    amount:,
    unit_price:
  )

  order.save!
  order_item.save!
end

orders = Order.all

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
