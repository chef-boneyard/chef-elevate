require 'chef/resource/execute'

class Chef
  class Resource
    class Elevate < Chef::Resource::Execute
      def initialize(name, run_context=nil)
        super
        @resource_name = :elevate
        @provider = Chef::Provider::Elevate::Sudo
      end
    end
  end
end
