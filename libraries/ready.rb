# frozen_string_literal: true

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

require_relative './helper'

# Aws class contains checks for AEM instance resource
class Ready < Inspec.resource(1)
  name 'ready'

  desc "
    Custom resource for AWS
  "

  def initialize
    conf = read_config
    client = init_aem_aws_client(conf)
    @client_aem_aws = init_aws_aem_instance_client(client, conf)

    @params = {}
  end

  def has_all_author_instances_ready?
    instances_healthy?('ready', @client_aem_aws.author)
  end

  def has_all_publish_instances_ready?
    asg_healthy?('ready', @client_aem_aws.publish)
  end

  def has_all_author_dispatcher_instances_ready?
    elb_healthy?('ready', @client_aem_aws.author_dispatcher)
  end

  def has_all_publish_dispatcher_instances_ready?
    elb_healthy?('ready', @client_aem_aws.publish_dispatcher)
  end

  def has_all_orchestrator_instances_ready?
    asg_healthy?('ready', @client_aem_aws.orchestrator)
  end

  def has_all_chaosmonkey_instances_ready?
    asg_healthy?('ready', @client_aem_aws.chaos_monkey)
  end

  def has_all_author_instances_been_successful_provision?
    successful_provisioned_components?('ready', @client_aem_aws.author)
  end

  def has_author_primary_instance_been_successful_provision?
    successful_provisioned_components?('ready', @client_aem_aws.author.author_primary)
  end

  def has_author_standby_instance_been_successful_provision?
    successful_provisioned_components?('ready', @client_aem_aws.author.author_standby)
  end

  def has_all_publish_instances_been_successful_provision?
    successful_provisioned_components?('ready', @client_aem_aws.publish)
  end

  def has_all_author_dispatcher_instances_been_successful_provision?
    successful_provisioned_components?('ready', @client_aem_aws.author_dispatcher)
  end

  def has_all_publish_dispatcher_instances_been_successful_provision?
    successful_provisioned_components?('ready', @client_aem_aws.publish_dispatcher)
  end

  def has_orchestrator_instance_been_successful_provision?
    successful_provisioned_components?('ready', @client_aem_aws.orchestrator)
  end

  def has_chaosmonkey_instance_been_successful_provision?
    successful_provisioned_components?('ready', @client_aem_aws.chaos_monkey)
  end

  def has_author_publish_dispatcher_instance_been_successful_provision?
    # Since we have a direct client connection for consolidated
    # we don't need to pass any component name for the client
    successful_provisioned_components?('ready', @client_aem_aws)
  end
end
