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
