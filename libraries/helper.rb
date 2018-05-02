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
  config_file = ENV['INSPEC_AEM_AWS_CONF'] || './conf/aem-aws.yml'
  config = YAML.load_file(config_file) if File.exist?(config_file)
  config_params = {}
  %w[profile access_key_id secret_access_key s3_bucket].each { |field|
    env_field = format('aws_%<field>s', field: field)
    if !ENV[env_field].nil?
      config_params[:"aws_#{field}"] = ENV[env_field]
    elsif !config.nil? && !config['aws'][field].nil?
      config_params[:"aws_#{field}"] = config['aws'][field]
    end
  }
  %w[stack_prefix component id].each { |field|
    env_field = format('aem_%<field>s', field: field)
    if !ENV[env_field].nil?
      config_params[:"aem_#{field}"] = ENV[env_field]
    elsif !config.nil? && !config['aem'][field].nil?
      config_params[:"aem_#{field}"] = config['aem'][field]
    end
  }
  config_params
end

def init_aem_aws_client(conf = {})
  RubyAemAws::AemAws.new(conf)
end

def init_aws_aem_instance_client(client, conf)
  if conf[:aem_component] == 'author-primary'
    client = client.full_set(conf[:aem_stack_prefix])
    [client, client.author.author_primary]
  elsif conf[:aem_component] == 'author-standby'
    client = client.full_set(conf[:aem_stack_prefix])
    [client, client.author.author_standby]
  elsif conf[:aem_component] == 'publish'
    client = client.full_set(conf[:aem_stack_prefix])
    [client, client.publish]
  elsif conf[:aem_component] == 'author-dispatcher'
    client = client.full_set(conf[:aem_stack_prefix])
    [client, client.author_dispatcher]
  elsif conf[:aem_component] == 'publish-dispatcher'
    client = client.full_set(conf[:aem_stack_prefix])
    [client, client.publish_dispatcher]
  elsif conf[:aem_component] == 'chaos-monkey'
    client = client.full_set(conf[:aem_stack_prefix])
    [client, client.chaos_monkey]
  elsif conf[:aem_component] == 'orchestrator'
    client = client.full_set(conf[:aem_stack_prefix])
    [client, client.orchestrator]
  elsif conf[:aem_component] == 'author-publish-dispatcher'
    client = client.consolidated(conf[:aem_stack_prefix])
    [client, client.author_publish_dispatcher]
  else
    client.full_set(conf[:aem_stack_prefix])
  end
end
