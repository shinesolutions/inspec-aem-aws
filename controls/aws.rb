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
  title 'Check if offline-snapshot is scheduled'
  desc 'Check if offline-snapshot is scheduled'
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
  title 'Check if offline-compaction-snapshot is scheduled'
  desc 'Check if offline-compaction-snapshot is scheduled'
  describe crontab.where { command =~ /stack-offline-compaction-snapshot.sh/ } do
    its('entries.length') { should cmp 0 }
  end
end
