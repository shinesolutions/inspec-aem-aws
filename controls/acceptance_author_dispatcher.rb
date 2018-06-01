control 'author-dispatcher-cloudwatch-ec2-metrics-exist' do
  impact 1.0
  title 'Check if dispatcher metrics exists'
  desc 'metrics should be available'
  describe acceptance do
    metrics = File.readlines('conf/cw_metrics.txt')
    metrics.each do |metric|
      it { should have_author_dispatcher_cloudwatch_ec2_metrics(metric.chomp) }
    end
  end
end

control 'author-dispatcher-cloudwatch-loggroups-exist' do
  impact 1.0
  title 'Check if dispatcher loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-dispatcher.txt')
    logfiles.each do |logfile|
      it { should have_author_dispatcher_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'author-dispatcher-cloudwatch-log-streams-exist' do
  impact 1.0
  title 'Check if dispatcher log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-dispatcher.txt')
    logfiles.each do |logfile|
      it { should have_author_dispatcher_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'author-dispatcher-generic-cloudwatch-log-streams-exist' do
  impact 1.0
  title 'Check if generic log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_author_dispatcher_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'author-dispatcher-generic-cloudwatch-loggroups-exist' do
  impact 1.0
  title 'Check if generic log streams exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_author_dispatcher_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'author-dispatcher-finished-provisioning' do
  impact 1.0
  title 'Check if author-dispatcher has finished provisioning process'
  desc 'provisioning should be done'
  describe acceptance do
    it { should have_author_dispatcher_cloudwatch_log_event('/var/log/shinesolutions/puppet-stack-init.log', 'Applied') }
  end
end
