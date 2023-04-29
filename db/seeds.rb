filepath = ENV.fetch('FILEPATH', Rails.root.join('db', 'states_cities.json').to_s)
states = JSON.parse(File.read(filepath))

states.each do |state|
  state_obj = State.find_or_create_by(acronym: state['acronym'], name: state['name'])

  state['cities'].each do |city|
    City.find_or_create_by(name: city['name'], state: state_obj)
    puts "Adicionando a cidade #{city['name']} ao estado #{state_obj.name}"
  end
end

admin_user = User.find_or_create_by(email: 'admin+1@rarolabs.com.br', cpf: '52947611578') do |model|
  model.attributes = {
    name: 'Admin RaroFood',
    password: 'VW1234**'
  }
end
Administrator.find_or_create_by(user: admin_user)