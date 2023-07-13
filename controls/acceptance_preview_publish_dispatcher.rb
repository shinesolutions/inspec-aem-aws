# frozen_string_literal: true

control 'preview-publish-dispatcher-cloudwatch-ec2-metrics-exist' do
  impact 1.0
  title 'Check if preview publish dispatcher metrics exists'
  desc 'metrics should be available'
  describe acceptance do
    metrics = File.readlines('conf/cw_metrics.txt')
    metrics.each do |metric|
      it { should have_preview_publish_dispatcher_cloudwatch_ec2_metrics(metric.chomp) }
    end
  end
end

control 'preview-publish-dispatcher-cloudwatch-loggroups-exist' do
  impact 1.0
  title 'Check if preview publish dispatcher loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-dispatcher.txt')
    logfiles.each do |logfile|
      it { should have_preview_publish_dispatcher_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'preview-publish-dispatcher-cloudwatch-log-streams-exist' do
  impact 1.0
  title 'Check if preview publish dispatcher log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-dispatcher.txt')
    logfiles.each do |logfile|
      it { should have_preview_publish_dispatcher_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'preview-publish-dispatcher-generic-cloudwatch-loggroups-exist' do
  impact 1.0
  title 'Check if generic preview publish dispatcher loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_preview_publish_dispatcher_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'preview-publish-dispatcher-generic-cloudwatch-log-streams-exist' do
  impact 1.0
  title 'Check if generic preview publish dispatcher log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_preview_publish_dispatcher_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'preview-publish-dispatcher-finished-provisioning' do
  impact 1.0
  title 'Check if publish-dispatcher has finished provisioning process'
  desc 'provisioning should be done'
  describe acceptance do
    it { should have_preview_publish_dispatcher_cloudwatch_log_event('/var/log/shinesolutions/puppet-stack-init.log', 'Applied') }
  end
end
