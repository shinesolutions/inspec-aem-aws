control 'orchestrator-cloudwatch-ec2-metrics-exist' do
  impact 1.0
  title 'Check if dispatcher metrics exists'
  desc 'metrics should be available'
  describe acceptance do
    metrics = File.readlines('conf/cw_metrics.txt')
    metrics.each do |metric|
      it { should have_orchestrator_cloudwatch_ec2_metrics(metric.chomp) }
    end
  end
end

control 'orchestrator-cloudwatch-loggroups-exist' do
  impact 1.0
  title 'Check if orchestrator loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-orchestrator.txt')
    logfiles.each do |logfile|
      it { should have_orchestrator_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'orchestrator-cloudwatch-log-streams-exist' do
  impact 1.0
  title 'Check if orchestrator log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-orchestrator.txt')
    logfiles.each do |logfile|
      it { should have_orchestrator_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'orchestrator-generic-cloudwatch-loggroups-exist' do
  impact 1.0
  title 'Check if generic dispatcher loggroups exists'
  desc 'loggroups should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_orchestrator_cloudwatch_loggroups(logfile.chomp) }
    end
  end
end

control 'orchestrator-generic-cloudwatch-log-streams-exist' do
  impact 1.0
  title 'Check if generic dispatcher log streams exists'
  desc 'log streams should be available'
  describe acceptance do
    logfiles = File.readlines('conf/log_files-generic.txt')
    logfiles.each do |logfile|
      it { should have_orchestrator_cloudwatch_log_streams(logfile.chomp) }
    end
  end
end

control 'orchestrator-finished-provisioning' do
  impact 1.0
  title 'Check if orchestrator has finished provisioning process'
  desc 'provisioning should be done'
  describe acceptance do
    it { should have_orchestrator_cloudwatch_log_event('/var/log/puppet-stack-init.log', 'Applied') }
  end
end
