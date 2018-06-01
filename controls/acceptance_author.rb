control 'author-primary-cloudwatch-ec2-metrics-exist' do
  impact 1.0
  title 'Check if author-primary metrics exists'
  desc 'metrics should be available'
  describe acceptance do
    metrics = File.readlines('conf/cw_metrics.txt')
    metrics.each do |metric|
      it { should have_author_primary_cloudwatch_ec2_metrics(metric.chomp) }
    end
  end
end

control 'author-primary-cloudwatch-collectd-generic-metric-exist' do
  impact 1.0
  title 'Check if author-primary collectd generic metrics exists'
  desc 'collectd metrics should be available'
  describe acceptance do
    metrics = File.readlines('conf/cw_metric_collectd-generic.txt')
    metrics.each do |metric|
      it { should have_author_primary_cloudwatch_collectd_metrics(metric.chomp) }
    end
  end
end

control 'author-primary-cloudwatch-loggroups-exist' do
  impact 1.0
  title 'Check if author-primary loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-author.txt')
    logfiles.each do |logfile|
      it { should have_author_primary_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'author-primary-cloudwatch-log-streams-exist' do
  impact 1.0
  title 'Check if author-primary log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-author.txt')
    logfiles.each do |logfile|
      it { should have_author_primary_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'author-primary-generic-cloudwatch-loggroups-exist' do
  impact 1.0
  title 'Check if generic loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_author_primary_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'author-primary-generic-cloudwatch-log-streams-exist' do
  impact 1.0
  title 'Check if generic log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_author_primary_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'author-primary-finished-provisioning' do
  impact 1.0
  title 'Check if author-primary has finished provisioning process'
  desc 'provisioning should be done'
  describe acceptance do
    it { should have_author_primary_cloudwatch_log_event('/var/log/shinesolutions/puppet-stack-init.log', 'Applied') }
  end
end

control 'author-standby-cloudwatch-ec2-metrics-exist' do
  impact 1.0
  title 'Check if author-standby metrics exists'
  desc 'metrics should be available'
  describe acceptance do
    metrics = File.readlines('conf/cw_metrics.txt')
    metrics.each do |metric|
      it { should have_author_standby_cloudwatch_ec2_metrics(metric.chomp) }
    end
  end
end

control 'author-standby-cloudwatch-collectd-generic-metric-exist' do
  impact 1.0
  title 'Check if author-standby collectd generic metrics exists'
  desc 'collectd metrics should be available'
  describe acceptance do
    metrics = File.readlines('conf/cw_metric_collectd-generic.txt')
    metrics.each do |metric|
      it { should have_author_standby_cloudwatch_collectd_metrics(metric.chomp) }
    end
  end
end

control 'author-standby-cloudwatch-collectd-sync-metric-exist' do
  impact 1.0
  title 'Check if author-standby collectd sync metric exists'
  desc 'collectd metrics should be available'
  describe acceptance do
    metrics = File.readlines('conf/cw_metric_collectd-author-standby.txt')
    metrics.each do |metric|
      it { should have_author_standby_cloudwatch_collectd_metrics(metric.chomp) }
    end
  end
end

control 'author-standby-cloudwatch-loggroups-exist' do
  impact 1.0
  title 'Check if author-standby loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-author.txt')
    logfiles.each do |logfile|
      it { should have_author_standby_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'author-standby-cloudwatch-log-streams-exist' do
  impact 1.0
  title 'Check if author-standby log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-author.txt')
    logfiles.each do |logfile|
      it { should have_author_standby_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'author-standby-generic-cloudwatch-loggroups-exist' do
  impact 1.0
  title 'Check if generic loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_author_standby_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'author-standby-generic-cloudwatch-log-streams-exist' do
  impact 1.0
  title 'Check if generic log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_author_standby_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'author-standby-finished-provisioning' do
  impact 1.0
  title 'Check if publisher has finished provisioning process'
  desc 'provisioning should be done'
  describe acceptance do
    it { should have_author_standby_cloudwatch_log_event('/var/log/shinesolutions/puppet-stack-init.log', 'Applied') }
  end
end
