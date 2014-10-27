# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
puts 'Creating admins, needed for entites'

users = []
%w(butsko.7 hinshaw.25 burgoon.5).each do |name_n|

  u = User.where(
    email: "#{name_n}@osu.edu",
    username: "#{name_n}@osu.edu",
  ).first_or_initialize

  if u.new_record?
    u.password = 'password'
    u.password_confirmation = 'password'
    u.save!
    puts "Created user #{u.email}"
  end

  users.push u
end

puts 'Creating entites...'

e = Entity.where(
    name: 'University Communications',
    description: 'Central communications office',
    link: 'http://ucom.osu.edu',
).first_or_create

e2 = Entity.where(
    name: 'Arts and Sciences Communications',
    description: 'College comm office',
    link: 'http://asccomm.osu.edu',
).first_or_create

e.users.push users
e2.users.push users


puts 'Creating keywords...'

Keyword.where(
  name: 'department',
  display_name: 'Department',
  description: 'Content pertaining to departments, offices, or business units. Add "-DEPARTMENTNUMBER" to refer to a specific department. Ex: department-34100',
).first_or_create



puts 'Creating contacts...'

Contact.create({
  organization: 'University Communications',
  url: 'http://ucom.osu.edu',
  phone: '614-555-5555',
  email: 'comments@osu.edu',
  contactable: e,
})


puts 'Creating channels...'

TwitterChannel.create([
  {
    name: '@OhioState',
    description: 'Main OSU twitter account',
    entity: e,
    primary: true,
    service_identifier: 'OhioState',
    url: 'https://twitter.com/OhioState',
  },{
    name: '@OhioStateLive',
    description: 'Ohio State live events',
    entity: e,
    primary: false,
    service_identifier: 'OhioStateLive',
    url: 'https://twitter.com/OhioStateLive',
  }
])
