
admin = User.create!(
    email:    'admin@example.com',
    password: 'helloworld'
)

premium = User.create!(
    email:    'premium@example.com',
    password: 'helloworld'
)

standard = User.create!(
    email:    'standard@example.com',
    password: 'helloworld'
)

users = User.all

10.times do
  RegisteredApplication.create!(
    name: Faker::Company.name,
    url: Faker::Internet.url,
    user: users.sample
  )
end

registered_applications = RegisteredApplication.all

20.times do
  Event.create!(
    name: Faker::Lorem.word,
    registered_application: registered_applications.sample
  )
end

events = Event.all

puts "Seed finished"
puts "#{User.count} users created"
puts "#{RegisteredApplication.count} registered applications created"
puts "#{Event.count} events created"
