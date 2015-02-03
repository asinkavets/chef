#
# Author:: Lamont Granquist <lamont@chef.io>)
# Copyright:: Copyright (c) 2015 Chef Software, Inc.
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

describe Chef::Knife::Bootstrap::ChefVaultHandler do

  let(:stdout) { StringIO.new }
  let(:stderr) { StringIO.new }
  let(:stdin) { StringIO.new }
  let(:ui) { Chef::Knife::UI.new(stdout, stderr, stdin, {}) }

  let(:knife_config) { {} }

  let(:node_name) { "bevell.wat" }

  let(:chef_vault_handler) {
    chef_vault_handler = Chef::Knife::Bootstrap::ChefVaultHandler.new(knife_config: knife_config, ui: ui)
    chef_vault_handler
  }

  context "when there's no vault option" do
    it "should report its not doing anything" do
      expect(chef_vault_handler.doing_chef_vault?).to be false
    end

    it "shouldn't do anything" do
      expect(chef_vault_handler).to_not receive(:sanity_check)
      expect(chef_vault_handler).to_not receive(:update_vault_list!)
      chef_vault_handler
    end
  end

  it "foo" do
    knife_config[:vault_item] = { 'vault' => [ 'item1' ] }
    expect(chef_vault_handler).to receive(:wait_for_client).and_return(false)
    expect(chef_vault_handler).not_to receive(:update_vault)
    chef_vault_handler.run(node_name: node_name)
  end
end
