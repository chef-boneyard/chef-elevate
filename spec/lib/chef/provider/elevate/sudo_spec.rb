#
# Author:: Adam Jacob (<adam@opscode.com>)
# Copyright:: Copyright (c) 2008 Opscode, Inc.
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require 'spec_helper'
require 'chef/node'
require 'chef/cookbook/cookbook_collection'
require 'chef/event_dispatch/dispatcher'
require 'chef/run_context'

describe Chef::Provider::Elevate::Sudo do
  let(:node) { Chef::Node.new }
  let(:cookbook_collection) { Chef::CookbookCollection.new([]) }
  let(:events) { Chef::EventDispatch::Dispatcher.new }
  let(:run_context) { Chef::RunContext.new(node, cookbook_collection, events) }
  let(:new_resource) { Chef::Resource::Elevate.new("echo elevate", run_context) }
  let(:provider) { Chef::Provider::Elevate::Sudo.new(new_resource, run_context) }

  it "inherits from Chef::Provider::Execute" do
    expect(provider).to be_a_kind_of(Chef::Provider::Execute)
  end

  describe "#sudo_prep" do
    describe "with no options" do
      it "prepends sudo on the command" do
        expect(provider.new_resource.command).to eql("sudo -- echo elevate")
      end

      describe "with the user param" do
        let(:new_resource) {
          r = Chef::Resource::Elevate.new("echo elevate", run_context)
          r.user "snoopy"
          r
        }

        it "appends -u" do
          expect(provider.new_resource.command).to eql("sudo -u snoopy -- echo elevate")
        end

        it "wipes out the user" do
          expect(provider.new_resource.user).to be_nil
        end
      end

      describe "with the group param" do
        let(:new_resource) {
          r = Chef::Resource::Elevate.new("echo elevate", run_context)
          r.group "snoopy"
          r
        }

        it "appends -g" do
          expect(provider.new_resource.command).to eql("sudo -g snoopy -- echo elevate")
        end

        it "wipes out the group" do
          expect(provider.new_resource.group).to be_nil
        end
      end

      describe "with the environment param" do
        let(:new_resource) {
          r = Chef::Resource::Elevate.new("echo elevate", run_context)
          r.environment({ "FOO" => "bar", "BAZ" => "bang" })
          r
        }

        it "adds the env" do
          expect(provider.new_resource.command).to eql("sudo FOO=bar BAZ=bang -- echo elevate")
        end
      end

      describe "with user, group, and environment" do
        let(:new_resource) {
          r = Chef::Resource::Elevate.new("echo elevate", run_context)
          r.user("snoopy")
          r.group("snoopy")
          r.environment({ "FOO" => "bar", "BAZ" => "bang" })
          r
        }

        it "adds the user, group, and env" do
          expect(provider.new_resource.command).to eql("sudo -u snoopy -g snoopy FOO=bar BAZ=bang -- echo elevate")
        end
      end
    end
  end

end

