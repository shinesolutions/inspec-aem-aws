# frozen_string_literal: true

control 'preview-publish-cloudwatch-ec2-metrics-exist' do
  impact 1.0
  title 'Check if preview publisher metrics exists'
  desc 'metrics should be available'
  describe acceptance do
    metrics = File.readlines('conf/cw_metrics.txt')
    metrics.each do |metric|
      it { should have_preview_publish_cloudwatch_ec2_metrics(metric.chomp) }
    end
  end
end

control 'preview-publish-cloudwatch-collectd-generic-metric-exist' do
  impact 1.0
  title 'Check if preview publish collectd generic metrics exists'
  desc 'collectd metrics should be available'
  describe acceptance do
    metrics = File.readlines('conf/cw_metric_collectd-generic.txt')
    metrics.each do |metric|
      it { should have_preview_publish_cloudwatch_collectd_metrics(metric.chomp) }
    end
  end
end

control 'preview-publish-generic-cloudwatch-loggroups-exist' do
  impact 1.0
  title 'Check if preview publisher loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_preview_publish_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'preview-publish-generic-cloudwatch-log-streams-exist' do
  impact 1.0
  title 'Check if preview publisher log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_preview_publish_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'preview-publish-cloudwatch-loggroups-exist' do
  impact 1.0
  title 'Check if preview publisher loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-preview-publish.txt')
    logfiles.each do |logfile|
      it { should have_preview_publish_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'preview-publish-cloudwatch-log-streams-exist' do
  impact 1.0
  title 'Check if preview publisher log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-preview-publish.txt')
    logfiles.each do |logfile|
      it { should have_preview_publish_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'preview-publish-finished-provisioning' do
  impact 1.0
  title 'Check if preview publisher has finished provisioning process'
  desc 'provisioning should be done'
  describe acceptance do
    it { should have_preview_publish_cloudwatch_log_event('/var/log/shinesolutions/puppet-stack-init.log', 'Applied') }
  end
end
