template "/etc/sudoers" do
  source "sudoers.erb"
  mode "0440"
  owner "root"
  group "root"
end

file "/tmp/chef-apply-cfg.rb" do
  mode "0644"
  content <<-EOH
cache_path "/tmp/chef-apply-cache"
EOH
end

directory "/tmp/elevate-cookbooks" do
  recursive true
  action [ :delete, :create ]
end

directory "/tmp/elevate-cookbooks/nodes" do
  owner "vagrant"
end

execute "cp -r /build/test/cookbooks /tmp/elevate-cookbooks"

execute "/opt/chef/bin/chef-client -z -c /tmp/chef-apply-cfg.rb -o 'elevate::non_root'" do
  user "vagrant"
  cwd "/tmp/elevate-cookbooks"
end
