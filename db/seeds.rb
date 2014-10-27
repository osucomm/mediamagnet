# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#
puts 'Creating admins, needed for entites'

%w(butsko.7 hinshaw.25 burgoon.5).each do |name_n|

  u = User.where(
    email: "#{name_n}@osu.edu"
  ).first_or_initialize

  if u.new_record?
    tmp_pass = (0...12).map { (65 + rand(26)).chr }.join
    u.password = tmp_pass
    u.encrypted_password = tmp_pass
    u.save!
    puts "Created user #{u.email}"
  end
end

puts 'Creating entites...'

e = Entity.where(
    name: 'University Communications',
    description: 'Central communications office',
    link: 'http://ucom.osu.edu',
).first_or_create

Entity.where(
    name: 'Arts and Sciences Communications',
    description: 'College comm office',
    link: 'http://asccomm.osu.edu',
).first_or_create

puts 'Creating keywords...'

Keyword.where(
  name: 'department',
  display_name: 'Department',
  description: 'Content pertaining to departments, offices, or business units. Add "-DEPARTMENTNUMBER" to refer to a specific department. Ex: department-34100',
).first_or_create
