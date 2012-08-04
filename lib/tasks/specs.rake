namespace :specs do
  task :setup do
    system('bundle install')
  end

  task :unit => ['specs:setup', 'db:create', 'db:migrate', 'db:test:prepare', :spec]

  task :cucumber => ['specs:setup', 'cucumber:all']

  task :smoke => [:spec]

end
