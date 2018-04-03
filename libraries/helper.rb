# Copyright 2018 Shine Solutions
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
require 'ruby_aem_aws'

def read_config
  config_file = ENV['INSPEC_AWS_CONF'] || './conf/aws.yml'
  config = YAML.load_file(config_file) if File.exist?(config_file)
  config_params = {}
  %w[aws_profile s3_bucket stack_prefix aws_access_key_id aws_secret_access_key component id].each { |field|
    env_field = format('aem_%<field>s', field: field)
    if !ENV[env_field].nil?
      config_params[field.to_sym] = ENV[env_field]
    elsif !config.nil? && !config[field.to_sym].nil?
      config_params[field.to_sym] = config[field.to_sym]
    else
      puts 'Using Default values from ruby_aem_aws'
    end
  }
  config_params
end

def init_aem_aws_client(conf = {})
  RubyAemAws::AemAws.new(conf)
end

def init_aws_aem_instance_client(client, conf)
  if conf[:component] == 'author-primary'
    client = client.full_set(conf[:stack_prefix])
    [client, client.author.author_primary]
  elsif conf[:component] == 'author-standby'
    client = client.full_set(conf[:stack_prefix])
    [client, client.author.author_standby]
  elsif conf[:component] == 'publish'
    client = client.full_set(conf[:stack_prefix])
    [client, client.publish]
  elsif conf[:component] == 'author-dispatcher'
    client = client.full_set(conf[:stack_prefix])
    [client, client.author_dispatcher]
  elsif conf[:component] == 'publish-dispatcher'
    client = client.full_set(conf[:stack_prefix])
    [client, client.publish_dispatcher]
  elsif conf[:component] == 'chaos-monkey'
    client = client.full_set(conf[:stack_prefix])
    [client, client.chaos_monkey]
  elsif conf[:component] == 'orchestrator'
    client = client.full_set(conf[:stack_prefix])
    [client, client.orchestrator]
  elsif conf[:component] == 'author-publish-dispatcher'
    client = client.consolidated(conf[:stack_prefix])
    [client, client.author_publish_dispatcher]
  else
    puts 'Component check not implemented yet'
  end
end
