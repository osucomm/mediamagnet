# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Keyword.first_or_create(
  name: 'department',
  display_name: 'Department',
  description: 'Content pertaining to departments, offices, or business units. Add "-DEPARTMENTNUMBER" to refer to a specific department. Ex: department-34100',
)

