namespace :db do
  desc 'Drop the database and reload schema'
  task :clear do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:schema:load'].invoke
  end
end