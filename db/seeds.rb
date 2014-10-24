# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts 'Creating entites...'

Entity.create([
  {
    name: 'University Communications',
    description: 'Central communications office',
    link: 'http://ucom.osu.edu',
  },{
    name: 'Arts and Sciences Communications',
    description: 'College comm office',
    link: 'http://asccomm.osu.edu'
  }
])
