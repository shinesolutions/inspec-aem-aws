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
class Aws < Inspec.resource(1)
  name 'aws'

  desc "
    Custom resource for AWS
  "

  def initialize
    conf = read_config
    client = init_aem_aws_client(conf)
    @client_sm = client.stack_manager(conf[:aem_stack_prefix])
    @client_aem_aws, @client_instance = init_aws_aem_instance_client(client, conf)

    @params = {
      s3_bucket: conf[:aws_s3_bucket],
      stack_prefix: conf[:aem_stack_prefix],
      component: conf[:aem_component],
      snapshot_id: ENV['snapshot_id'],
      export_package_group: ENV['package_group'],
      export_package_name: ENV['package_name'],
      export_package_version: ENV['package_version'],
      export_package_backup_path: ENV['backup_path']
    }
  end

  def has_live_snapshots?
    @client_instance.snapshots?('live')
  end

  def has_offline_snapshots?
    @client_instance.snapshots?('offline')
  end

  def has_snapshot_taken?
    @client_instance.snapshot?(@params[:snapshot_id])
  end

  def has_package_exported?
    package_source = "backup/#{@params[:stack_prefix]}/#{@params[:export_package_group]}/#{@params[:export_package_backup_path]}/#{@params[:export_package_name]}-#{@params[:export_package_version]}.zip"
    @client_sm.sm_resources.s3_resource_object(@params[:s3_bucket], package_source).exists?
  end

  def has_cloudwatch_metric?(dimensions_name, dimensions_value, namespace, metric_name)
    @client_instance.metric?(dimensions_name, dimensions_value, namespace, metric_name)
  end

  def has_cloudwatch_loggroup?(loggroup_name)
    @client_instance.loggroup?(loggroup_name)
  end

  def has_cloudwatch_log_stream?(loggroup_name, logfile_name)
    @client_instance.log_stream?(loggroup_name, logfile_name)
  end

  def has_cloudwatch_alarm?(alarm_name)
    @client_instance.alarm?(alarm_name)
  end

  def has_cloudwatch_log_event?(loggroup_name, logfile_name, log_message)
    @client_instance.log_event?(loggroup_name, logfile_name, log_message)
  end
end
