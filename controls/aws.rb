control 'aws-snapshot-exists' do
  impact 1.0
  title 'Check if the snapshot exists on AWS'
  desc 'Check if the snapshot exists on AWS'
  describe aws do
    it { should have_snapshot_taken }
  end
end

control 'aws-export-package-available' do
  impact 1.0
  title 'Check if a package was exported'
  desc 'Check if a package was exported'
  describe aws do
    it { should have_package_exported }
  end
end

control 'aws-scheduled-job-offline-snapshot-enabled' do
  impact 1.0
  title 'Check if offline-snapshot is scheduled'
  desc 'Check if offline-snapshot is scheduled'
  describe crontab.where { command =~ /stack-offline-snapshot.sh/ } do
    its('entries.length') { should cmp 1 }
  end
end

control 'aws-scheduled-job-offline-snapshot-disabled' do
  impact 1.0
  title 'Check if offline-snapshot is unscheduled'
  desc 'Check if offline-snapshot is unscheduled'
  describe crontab.where { command =~ /stack-offline-snapshot.sh/ } do
    its('entries.length') { should cmp 0 }
  end
end

control 'aws-scheduled-job-offline-compaction-snapshot-enabled' do
  impact 1.0
  title 'Check if offline-compaction-snapshot is scheduled'
  desc 'Check if offline-compaction-snapshot is scheduled'
  describe crontab.where { command =~ /stack-offline-compaction-snapshot.sh/ } do
    its('entries.length') { should cmp 1 }
  end
end

control 'aws-scheduled-job-offline-compaction-snapshot-disabled' do
  impact 1.0
  title 'Check if offline-compaction-snapshot is unscheduled'
  desc 'Check if offline-compaction-snapshot is unscheduled'
  describe crontab.where { command =~ /stack-offline-compaction-snapshot.sh/ } do
    its('entries.length') { should cmp 0 }
  end
end

control 'aws-scheduled-job-live-snapshot-enabled' do
  impact 1.0
  title 'Check if live-snapshot is scheduled'
  desc 'Check if live-snapshot is scheduled'
  describe crontab.where { command =~ /live-snapshot-backup.sh/ } do
    its('entries.length') { should cmp 1 }
  end
end

control 'aws-scheduled-job-live-snapshot-disabled' do
  impact 1.0
  title 'Check if live-snapshot is unscheduled'
  desc 'Check if live-snapshot is unscheduled'
  describe crontab.where { command =~ /live-snapshot-backup.sh/ } do
    its('entries.length') { should cmp 0 }
  end
end

control 'cloudwatch-metric-exist' do
  impact 1.0
  title 'Check if metric exist'
  desc 'metric should be available'
  describe aws do
    metrics = File.readlines('conf/cw_metrics.txt')
    metrics.each do |metric|
      it { should have_cloudwatch_ec2_metric(metric.chomp) }
    end
  end
end

control 'cloudwatch-log-stream-exist' do
  impact 1.0
  title 'Check if log stream exists'
  desc 'log stream should be available'
  describe aws do
    logfiles = File.readlines('conf/log_files.txt')
    logfiles.each do |logfile|
      it { should have_cloudwatch_log_stream(logfile.chomp) }
    end
  end
end

control 'cloudwatch-loggroup-exist' do
  impact 1.0
  title 'Check if loggroup exist'
  desc 'loggroup should be available'
  describe aws do
    logfiles = File.readlines('conf/log_files.txt')
    logfiles.each do |logfile|
      it { should have_cloudwatch_loggroup(logfile.chomp) }
    end
  end
end

control 'cloudwatch-alarm-exist' do
  impact 1.0
  title 'Check if alarm exists'
  desc 'alarm should be available'
  describe aws do
    alarmns = File.readlines('conf/cw_alarms.txt')
    alarmns.each do |alarm|
      it { should have_cloudwatch_alarm(alarm.chomp) }
    end
  end
end

control 'cloudwatch-log-event-exist' do
  impact 1.0
  title 'Check if log event exists'
  desc 'log event should be available'
  describe aws do
    it { should have_cloudwatch_log_event('/var/log/messages', '/var/log/messages', 'systemd') }
  end
end
