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
class Aws < Inspec.resource(1)
  name 'aws'

  desc "
    Custom resource for AWS
  "

  def initialize
    conf = read_config
    client = init_aem_aws_client(conf)
    @client_sm = client.stack_manager(conf[:stack_prefix])
    @client_aem_aws, @client_instance = init_aws_aem_instance_client(client, conf)

    @params = {
      s3_bucket: conf[:s3_bucket],
      stack_prefix: conf[:stack_prefix],
      component: conf[:component],
      snapshot_id: ENV['snapshot_id'],
      export_package_group: ENV['package_group'],
      export_package_name: ENV['package_name'],
      export_package_version: ENV['package_version'],
      export_package_backup_path: ENV['backup_path']
    }
  end

  def has_author_instances?
    instance = 0
    instance += 1  unless @client_aem_aws.author.author_primary.healthy?.eql? false
    instance += 1  unless @client_aem_aws.author.author_standby.healthy?.eql? false
    return true unless instance < 2
  end

  def has_author_primary_terminated?
    @client_aem_aws.author.terminate_primary_instance
  end

  def has_author_standby_terminated?
    @client_aem_aws.author.terminate_standby_instance
  end

  def has_live_snapshots?
    @client_instance.snapshots?('live')
  end

  def has_live_snapshot_taken?
    @client_instance.snapshot?(@params[:snapshot_id])
  end

  def has_package_exported?
    package_source = "backup/#{@params[:stack_prefix]}/#{@params[:export_package_group]}/#{@params[:export_package_backup_path]}/#{@params[:export_package_name]}-#{@params[:export_package_version]}.zip"
    @client_sm.sm_resources.s3_resource_object(@params[:s3_bucket], package_source).exists?
  end
end
# no pipe test
def has_packages_described_in_descriptor?(descriptor_file, aem_client, instance)
  file = Tempfile.new('descriptor_file')
  @client_sm.sm_resources.s3_download_object(@params[:s3_bucket], "#{@params[:stack_prefix]}/#{descriptor_file}", file)
  deploy_artifacts_descriptor_file = file.read
  deploy_artifacts_hash_map = JSON.parse(deploy_artifacts_descriptor_file)
  exit_code = 0
  if deploy_artifacts_hash_map[instance.descriptor.ec2.component].include?('packages').eql? TRUE
    i = deploy_artifacts_hash_map[instance.descriptor.ec2.component]['packages'].length
    ii = 0
    while ii < i
      @package_group = deploy_artifacts_hash_map[instance.descriptor.ec2.component]['packages'][ii]['group']
      @package_name = deploy_artifacts_hash_map[instance.descriptor.ec2.component]['packages'][ii]['name']
      @package_version = deploy_artifacts_hash_map[instance.descriptor.ec2.component]['packages'][ii]['version']
      package = aem_client.package(@package_group, @package_name, @package_version)
      result = package.exists
      exit_code += 1 unless result.message.eql? "Package #{@package_group}/#{@package_name}-#{@package_version} does not exist"
      ii += 1
    end
  end
  return TRUE unless exit_code == 0
end
