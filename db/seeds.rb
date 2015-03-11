# This file should contain all the record creation needed to seed the database
# with its default values. The data can then be loaded with the rake db:seed (or
# created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#

puts 'Creating users...'

users = []
[
  { name: 'Brutus Buckeye', email: 'buckeye.1@osu.edu', admin: true },
  { name: 'Jake Fake', email: 'fake.1@osu.edu' },
  { name: 'Jane Doe', email: 'doe.1@osu.edu' }
].each do |u|
  user = User.where(u).first_or_create
  user.identities.first_or_create(uid: user.email, provider: 'shibboleth')
  users << user
end


puts 'Creating entites...'

e = Entity.where(
    name: 'University Communications',
    description: 'Central communications office',
    link: 'http://ucom.osu.edu',
).first_or_create

e2 = Entity.where(
    name: 'Example Entity',
    description: 'A communications group',
    link: 'http://example.osu.edu',
).first_or_create

e.users.push users[0]
e.users.push users[1]
e2.users.push users[2]


puts 'Creating contacts...'

Contact.create({
  organization: 'University Communications',
  url: 'http://ucom.osu.edu',
  phone: '614-555-5555',
  email: 'comments@osu.edu',
  contactable: e
})


puts 'Creating channels...'

TwitterChannel.create([
  {
    name: '@OhioState',
    description: 'Main OSU twitter account',
    entity: e,
    primary: true,
    service_identifier: 'OhioState',
    url: 'https://twitter.com/OhioState'
  }
])

RssChannel.create([
  {
    name: 'OSU.edu Features',
    description: 'Feature articles from the Ohio State web site',
    entity: e,
    service_identifier: 'http://www.osu.edu/feeds/features.rss',
    url: 'http://www.osu.edu/features/'
  }
])

RssChannel.create([
  {
    name: 'OSU Image of the Day',
    description: 'Images from the Ohio State University',
    entity: e2,
    primary: true,
    service_identifier: 'http://www.osu.edu/rss.php?feed=ImgDay&limit=10',
    url: 'http://www.osu.edu/imageoftheday/'
  }
])


puts 'Creating categories...'

Category.first_or_create([
  { name: 'course', template: true },
  { name: 'department', template: true },
  { name: 'person', template: true },
  { name: 'audience' },
  { name: 'location' },
  { name: 'college' },
  { name: 'format' }
])
