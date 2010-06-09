# Setup database.yml
dbtype = 'postgresql'

node.engineyard.apps.each do |app|

  template "/data/#{app.name}/shared/config/database.yml" do
    owner node.engineyard.environment.ssh_username
    group node.engineyard.environment.ssh_username
    mode 0655
    source "database.yml.erb"
    variables({
      :dbuser => node.engineyard.environment.ssh_username,
      :dbpass => node.engineyard.environment.ssh_password,
      :dbname => app.database_name,
      :dbhost => node.engineyard.environment.db_host,
      :dbtype => dbtype,
      :slaves => node.engineyard.environment.db_slaves_hostnames
    })
  end
end