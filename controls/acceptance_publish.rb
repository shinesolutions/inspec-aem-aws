# frozen_string_literal: true

control 'publish-cloudwatch-ec2-metrics-exist' do
  impact 1.0
  title 'Check if publisher metrics exists'
  desc 'metrics should be available'
  describe acceptance do
    metrics = File.readlines('conf/cw_metrics.txt')
    metrics.each do |metric|
      it { should have_publish_cloudwatch_ec2_metrics(metric.chomp) }
    end
  end
end

control 'publish-cloudwatch-contentHealthCheck-metric-exist' do
  impact 1.0
  title 'Check if publisher contentHealthCheck metric exists'
  desc 'contentHealthCheck metric should be available'
  describe acceptance do
    it { should have_contenthealthcheck_cloudwatch_alarms }
  end
end

control 'publish-cloudwatch-collectd-generic-metric-exist' do
  impact 1.0
  title 'Check if author-standby collectd generic metrics exists'
  desc 'collectd metrics should be available'
  describe acceptance do
    metrics = File.readlines('conf/cw_metric_collectd-generic.txt')
    metrics.each do |metric|
      it { should have_publish_cloudwatch_collectd_metrics(metric.chomp) }
    end
  end
end

control 'publish-generic-cloudwatch-loggroups-exist' do
  impact 1.0
  title 'Check if publisher loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_publish_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'publish-generic-cloudwatch-log-streams-exist' do
  impact 1.0
  title 'Check if publisher log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_publish_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'publish-cloudwatch-loggroups-exist' do
  impact 1.0
  title 'Check if publisher loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-publish.txt')
    logfiles.each do |logfile|
      it { should have_publish_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'publish-cloudwatch-log-streams-exist' do
  impact 1.0
  title 'Check if publisher log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-publish.txt')
    logfiles.each do |logfile|
      it { should have_publish_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'publish-finished-provisioning' do
  impact 1.0
  title 'Check if publisher has finished provisioning process'
  desc 'provisioning should be done'
  describe acceptance do
    it { should have_publish_cloudwatch_log_event('/var/log/shinesolutions/puppet-stack-init.log', 'Applied') }
  end
end

control 'publish-contenthealthcheck-alarm-ok' do
  impact 1.0
  title 'Check if alarm state of contenthealthcheck is OK'
  desc 'alarm state should be ok'
  describe acceptance do
    it { should have_contenthealthcheck_cloudwatch_alarm_state_ok }
  end
end

control 'publish-wait-until-contenthealthcheck-alarm-ok' do
  impact 1.0
  title 'Waits until contenthealthcheck alarm state is OK'
  desc 'alarm state should be ok'
  describe acceptance do
    it { should have_wait_until_contenthealthcheck_cloudwatch_alarm_state_ok }
  end
end
