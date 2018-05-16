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
class Recovery < Inspec.resource(1)
  name 'recovery'

  desc "
    Custom resource for AWS
  "

  def initialize
    conf = read_config
    client = init_aem_aws_client(conf)
    @client_aem_aws = init_aws_aem_instance_client(client, conf)

    @params = {}
  end

  def has_all_author_instances?
    instances_healthy?('recovery', @client_aem_aws.author)
  end

  def has_terminated_author_primary_instance?
    @client_aem_aws.author.author_primary.terminate
  end

  def has_terminated_author_standby_instance?
    @client_aem_aws.author.author_standby.terminate
  end

  def has_terminated_all_author_dispatcher_instances?
    @client_aem_aws.author_dispatcher.terminate_all_instances
  end

  def has_terminated_a_random_author_dispatcher_instance?
    @client_aem_aws.author_dispatcher.terminate_random_instance
  end

  def able_to_recover_from_author_dispatcher_termination?
    elb_healthy?('recovery', @client_aem_aws.author_dispatcher)
  end

  def has_terminated_all_publish_instances?
    @client_aem_aws.publish.terminate_all_instances
  end

  def has_terminated_a_random_publish_instance?
    @client_aem_aws.publish.terminate_random_instance
  end

  def able_to_recover_from_publish_termination?
    instances_healthy?('recovery', @client_aem_aws.publish)
  end

  def has_terminated_all_publish_dispatcher_instances?
    @client_aem_aws.publish_dispatcher.terminate_all_instances
  end

  def has_terminated_a_random_publish_dispatcher_instance?
    @client_aem_aws.publish_dispatcher.terminate_random_instance
  end

  def able_to_recover_from_publish_dispatcher_termination?
    elb_healthy?('recovery', @client_aem_aws.publish_dispatcher)
  end
end
