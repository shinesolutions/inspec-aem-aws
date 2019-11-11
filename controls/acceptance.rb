# frozen_string_literal: true

control 'cloudwatch-component-ec2-metrics-exist' do
  impact 1.0
  title 'Check if component metrics exists'
  desc 'metrics should be available'
  describe acceptance do
    metrics = File.readlines('conf/cw_metrics.txt')
    metrics.each do |metric|
      it { should have_component_cloudwatch_ec2_metrics(metric.chomp) }
    end
  end
end

control 'cloudwatch-component-log-streams-exist' do
  impact 1.0
  title 'Check if component log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_component_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'cloudwatch-component-loggroups-exist' do
  impact 1.0
  title 'Check if component loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_component_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'cloudwatch-component-log-event-exist' do
  impact 1.0
  title 'Check if component loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    it { should have_component_cloudwatch_log_event('/var/log/messages', 'systemd') }
  end
end
