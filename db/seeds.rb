# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Creating entites...'

entity1 = Entity.create({
  name: 'University Communications',
  description: 'Central communications office',
  link: 'http://ucom.osu.edu',
})
entity2 = Entity.create({
  name: 'Arts and Sciences Communications',
  description: 'College comm office',
  link: 'http://asccomm.osu.edu',
})


puts 'Creating contacts...'

Contact.create({
  organization: 'University Communications',
  url: 'http://ucom.osu.edu',
  phone: '614-555-5555',
  email: 'comments@osu.edu',
  contactable: entity1,
})


puts 'Creating channels...'

TwitterChannel.create([
  {
    name: '@OhioState',
    description: 'Main OSU twitter account',
    entity: entity1,
    primary: true,
    service_identifier: 'OhioState',
    url: 'https://twitter.com/OhioState',
  },{
    name: '@OhioStateLive',
    description: 'Ohio State live events',
    entity: entity1,
    primary: false,
    service_identifier: 'OhioStateLive',
    url: 'https://twitter.com/OhioStateLive',
  }
])


puts 'Creating keywords...'

Keyword.first_or_create(
  name: 'department',
  display_name: 'Department',
  description: 'Content pertaining to departments, offices, or business units. Add "-DEPARTMENTNUMBER" to refer to a specific department. Ex: department-34100',
)


puts 'Creating users...'

user1 = User.create({
  username: 'brutus.1@osu.edu',
  fullname: 'Brutus Buckeye',
  email: 'buckeye.1@osu.edu',
  password: 'password',
  password_confirmation: 'password',
})

user2 = User.create({
  username: 'fake.999999@osu.edu',
  fullname: 'Jake Fake',
  email: 'fake.999999@osu.edu',
  password: 'password',
  password_confirmation: 'password',
})

entity1.users.push [ user1, user2 ]
entity2.users.push user1
