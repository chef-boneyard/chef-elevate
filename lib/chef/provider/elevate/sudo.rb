require 'chef/provider/execute'
require 'chef/platform'

class Chef
  class Provider
    class Elevate
      class Sudo < Chef::Provider::Execute

        def initialize(new_resource, run_context)
          resource = sudo_prep(new_resource)
          super(resource, run_context)
        end

        def sudo_prep(resource)
          cmd = "sudo"
          if resource.user
            cmd << " -u #{resource.user}"
            # Sorry about this - don't have much choice if you want to zero it out
            resource.instance_variable_set(:@user, nil)
          end

          if resource.group
            cmd << " -g #{resource.group}"
            resource.instance_variable_set(:@group, nil)
          end

          if resource.environment
            resource.environment.each do |k, v|
              cmd << " #{k}=#{v}"
            end
          end

          cmd << " -- #{resource.command}"
          resource.command(cmd)
          resource
        end

      end
    end
  end
end

