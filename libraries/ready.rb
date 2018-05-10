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
    @client_aem_aws.author.wait_until_healthy
  end

  def has_all_publish_instances_ready?
    @client_aem_aws.publish.wait_until_healthy
  end

  def has_all_author_dispatcher_instances_ready?
    elb_healthy?('ready', @client_aem_aws.author_dispatcher)
  end

  def has_all_publish_dispatcher_instances_ready?
    elb_healthy?('ready', @client_aem_aws.publish_dispatcher)
  end
end
