control 'aem-author-instances-available' do
  impact 1.0
  title 'Check available AEM Author instances'
  desc 'Check available AEM Author instances'
  describe aws do
    it { should have_author_instances }
  end
end

control 'aws-live-snapshot-exists' do
  impact 1.0
  title 'Check if a Live snapshot exists'
  desc 'Check if a Live snapshot exists'
  describe aws do
    it { should have_live_snapshot_taken }
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
