# frozen_string_literal: true

control 'author-instances-ready' do
  impact 1.0
  title 'Check if Author instances are ready'
  desc 'Check if Author instances are ready'
  describe ready do
    it { should have_all_author_instances_ready }
  end
end

control 'publish-instances-ready' do
  impact 1.0
  title 'Check if Publish instances are ready'
  desc 'Check if Publish instances are ready'
  describe ready do
    it { should have_all_publish_instances_ready }
  end
end

control 'author-dispatcher-instances-ready' do
  impact 1.0
  title 'Check if Author Dispatcher instances are ready'
  desc 'Check if Author Dispatcher instances are ready'
  describe ready do
    it { should have_all_author_dispatcher_instances_ready }
  end
end

control 'publish-dispatcher-instances-ready' do
  impact 1.0
  title 'Check if Publish Dispatcher instances are ready'
  desc 'Check if Publish Dispatcher instances are ready'
  describe ready do
    it { should have_all_publish_dispatcher_instances_ready }
  end
end

control 'orchestrator-instances-ready' do
  impact 1.0
  title 'Check if Orchestrator instances are ready'
  desc 'Check if Orchestrator instances are ready'
  describe ready do
    it { should have_all_orchestrator_instances_ready }
  end
end

control 'chaosmonkey-instances-ready' do
  impact 1.0
  title 'Check if Chaosmonkey instances are ready'
  desc 'Check if Chaosmonkey instances are ready'
  describe ready do
    it { should have_all_chaosmonkey_instances_ready }
  end
end
