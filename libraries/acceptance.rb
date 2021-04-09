# frozen_string_literal: true

# Copyright 2018-2021 Shine Solutions Group
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
class Acceptance < Inspec.resource(1)
  name 'acceptance'

  desc "
    Custom resource for AWS
  "

  def initialize
    conf = read_config
    client = init_aem_aws_client(conf)
    @client_sm = client.stack_manager(conf[:aem_stack_prefix])
    @client_aem_aws, @client_instance = init_aws_aem_instance_client(client, conf)

    @params = {
      stack_prefix: conf[:aem_stack_prefix],
      component: conf[:aem_component]
    }
  end

  def has_component_cloudwatch_ec2_metrics?(metric_name)
    @client_instance.component_ec2_metric?(metric_name)
  end

  def has_component_cloudwatch_loggroups?(logfile_name)
    @client_instance.component_loggroup?(logfile_name)
  end

  def has_component_cloudwatch_log_streams?(logfile_name)
    @client_instance.component_log_stream?(logfile_name)
  end

  def has_component_cloudwatch_alarms?(alarm_name)
    @client_instance.component_alarm?(alarm_name)
  end

  def has_component_cloudwatch_log_event?(logfile_name, log_message)
    @client_instance.component_log_event?(logfile_name, log_message)
  end

  def has_all_full_set_cloudwatch_alarms?(alarm_name)
    alarm_name = "#{@params[:stack_prefix]}-#{alarm_name}"
    @client_aem_aws.alarm?(alarm_name)
  end

  def has_author_primary_cloudwatch_ec2_metrics?(metric_name)
    @client_aem_aws.author.author_primary.component_ec2_metric?(metric_name)
  end

  def has_author_primary_cloudwatch_loggroups?(logfile_name)
    @client_aem_aws.author.author_primary.component_loggroup?(logfile_name)
  end

  def has_author_primary_cloudwatch_log_streams?(logfile_name)
    @client_aem_aws.author.author_primary.component_log_stream?(logfile_name)
  end

  def has_author_primary_cloudwatch_log_event?(logfile_name, log_message)
    @client_aem_aws.author.author_primary.component_log_event?(logfile_name, log_message)
  end

  def has_author_primary_cloudwatch_collectd_metrics?(metric_name)
    namespace = 'collectd'
    @client_aem_aws.author.author_primary.component_metric?(namespace, metric_name)
  end

  def has_author_standby_cloudwatch_ec2_metrics?(metric_name)
    @client_aem_aws.author.author_standby.component_ec2_metric?(metric_name)
  end

  def has_author_standby_cloudwatch_collectd_metrics?(metric_name)
    namespace = 'collectd'
    @client_aem_aws.author.author_standby.component_metric?(namespace, metric_name)
  end

  def has_author_standby_cloudwatch_loggroups?(logfile_name)
    @client_aem_aws.author.author_standby.component_loggroup?(logfile_name)
  end

  def has_author_standby_cloudwatch_log_streams?(logfile_name)
    @client_aem_aws.author.author_standby.component_log_stream?(logfile_name)
  end

  def has_author_standby_cloudwatch_log_event?(logfile_name, log_message)
    @client_aem_aws.author.author_standby.component_log_event?(logfile_name, log_message)
  end

  def has_publish_cloudwatch_collectd_metrics?(metric_name)
    namespace = 'collectd'
    @client_aem_aws.publish.component_metric?(namespace, metric_name)
  end

  def has_publish_cloudwatch_ec2_metrics?(metric_name)
    @client_aem_aws.publish.component_ec2_metric?(metric_name)
  end

  def has_publish_cloudwatch_loggroups?(logfile_name)
    @client_aem_aws.publish.component_loggroup?(logfile_name)
  end

  def has_publish_cloudwatch_log_streams?(logfile_name)
    @client_aem_aws.publish.component_log_stream?(logfile_name)
  end

  def has_contenthealthcheck_cloudwatch_alarms?
    instances_with_metric = []
    client = @client_aem_aws.publish

    instances = client.get_all_instances
    instances_found = instances.count

    instances.each do |instance|
      next if instance.nil? || instance.state.code != 16

      instance_id = instance.instance_id

      alarm_name = "contentHealthCheck-#{instance_id}"

      response = client.component_alarm?(alarm_name)

      instances_with_metric.push(instance_id) if response.eql? true
    end
    instances_with_metric = instances_with_metric.count

    return true unless instances_with_metric < instances_found
  end

  def has_contenthealthcheck_cloudwatch_alarm_state_ok?
    instances_with_metric = []
    client = @client_aem_aws.publish

    instances = client.get_all_instances
    instances_found = instances.count
    return false if instances_found.eql? 0

    instances.each do |instance|
      next if instance.nil? || instance.state.code != 16

      instance_id = instance.instance_id

      alarm_name = "contentHealthCheck-#{instance_id}"

      response = get_alarm_state(alarm_name, client)

      instances_with_metric.push(instance_id) if response.eql? true
    end
    instances_with_metric = instances_with_metric.count

    return true unless instances_with_metric < instances_found
  end

  def has_wait_until_contenthealthcheck_cloudwatch_alarm_state_ok?
    instances_with_metric = []
    client = @client_aem_aws.publish

    instances = client.get_all_instances
    instances_found = instances.count
    return false if instances_found.eql? 0

    instances.each do |instance|
      next if instance.nil? || instance.state.code != 16

      instance_id = instance.instance_id

      alarm_name = "contentHealthCheck-#{instance_id}"

      response = wait_until_alarm_state_ok(alarm_name, client)

      instances_with_metric.push(instance_id) if response.eql? true
    end
    instances_with_metric = instances_with_metric.count

    return true unless instances_with_metric < instances_found
  end

  def has_publish_cloudwatch_log_event?(logfile_name, log_message)
    @client_aem_aws.publish.component_log_event?(logfile_name, log_message)
  end

  def has_author_dispatcher_cloudwatch_ec2_metrics?(metric_name)
    @client_aem_aws.author_dispatcher.component_ec2_metric?(metric_name)
  end

  def has_author_dispatcher_cloudwatch_loggroups?(logfile_name)
    @client_aem_aws.author_dispatcher.component_loggroup?(logfile_name)
  end

  def has_author_dispatcher_cloudwatch_log_streams?(logfile_name)
    @client_aem_aws.author_dispatcher.component_log_stream?(logfile_name)
  end

  def has_author_dispatcher_cloudwatch_log_event?(logfile_name, log_message)
    @client_aem_aws.author_dispatcher.component_log_event?(logfile_name, log_message)
  end

  def has_publish_dispatcher_cloudwatch_ec2_metrics?(metric_name)
    @client_aem_aws.publish_dispatcher.component_ec2_metric?(metric_name)
  end

  def has_publish_dispatcher_cloudwatch_loggroups?(logfile_name)
    @client_aem_aws.publish_dispatcher.component_loggroup?(logfile_name)
  end

  def has_publish_dispatcher_cloudwatch_log_streams?(logfile_name)
    @client_aem_aws.publish_dispatcher.component_log_stream?(logfile_name)
  end

  def has_publish_dispatcher_cloudwatch_log_event?(logfile_name, log_message)
    @client_aem_aws.publish_dispatcher.component_log_event?(logfile_name, log_message)
  end

  def has_orchestrator_cloudwatch_ec2_metrics?(metric_name)
    @client_aem_aws.orchestrator.component_ec2_metric?(metric_name)
  end

  def has_orchestrator_cloudwatch_loggroups?(logfile_name)
    @client_aem_aws.orchestrator.component_loggroup?(logfile_name)
  end

  def has_orchestrator_cloudwatch_log_streams?(logfile_name)
    @client_aem_aws.orchestrator.component_log_stream?(logfile_name)
  end

  def has_orchestrator_cloudwatch_log_event?(logfile_name, log_message)
    @client_aem_aws.orchestrator.component_log_event?(logfile_name, log_message)
  end
end
