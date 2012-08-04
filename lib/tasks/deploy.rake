def deploy(env, upstream_tag, downstream_tag)
    sh "git fetch --tags"
    commit = `git rev-list #{upstream_tag} -1`.chomp
    log = `git log #{upstream_tag} --pretty=oneline -1`
    puts "Deploying  #{log} to #{env}"
    system "git tag -d #{downstream_tag}"
    system "git push origin :#{downstream_tag}"
    sh "git tag #{downstream_tag} #{commit}"
    sh "git push origin #{downstream_tag}"
end

namespace :deploy do

  task :integration do
    deploy 'integration', 'HEAD', 'ready_for_qa'
  end

  task :qa do
    deploy 'qa', 'ready_for_qa', 'in_qa'
  end

  task :uat do
    deploy 'uat', 'ready_for_uat', 'in_uat'
  end

  task :staging do
    deploy 'staging', 'ready_for_staging', 'ready_for_production'
  end

  task :production do
    deploy 'production', 'ready_for_production', 'in_production'
  end

  task :demo do
    deploy 'demo', 'in_production', 'in_demo'
  end

  namespace :signoff do
    task :qa do
      deploy 'qa', 'in_qa', 'ready_for_uat'
    end

    task :uat do
      deploy 'uat', 'in_uat', 'ready_for_staging'
    end
  end
end
