#
# Cookbook Name:: github_key
# Recipe:: default
#

ey_cloud_report "github_key" do
  message "Running Custom Github SSH Key Chef Configuration"
end

# loop over all application instances

node[:applications].each do |app_name,data|
  user = node[:users].first

identity = "/home/deploy/.ssh/#{app_name}-deploy-key"
puts identity

case node[:instance_role]
 when "solo", "app", "app_master"
   template "/root/.ssh/config" do
     source "sshconfig.erb"
     owner "root"
     group "root"
     mode 0744
     variables({
         :identity => identity
     })
   end

 end
end
