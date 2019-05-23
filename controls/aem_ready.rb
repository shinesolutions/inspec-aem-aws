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

control 'author-instances-provisioned-successful' do
  impact 1.0
  title 'Check if Author instances have been provisioned successful'
  desc 'Check author provision state'
  describe ready do
    it { should have_all_author_instances_been_successful_provision }
  end
end

control 'author-primary-instance-provisioned-successful' do
  impact 1.0
  title 'Check if Author Primary instance has been provisioned successful'
  desc 'Check author primary provision state'
  describe ready do
    it { should have_author_primary_instance_been_successful_provision }
  end
end

control 'author-standby-instance-provisioned-successful' do
  impact 1.0
  title 'Check if Author Standby instance has been provisioned successful'
  desc 'Check author standby provision state'
  describe ready do
    it { should have_author_standby_instance_been_successful_provision }
  end
end

control 'publish-instances-provisioned-successful' do
  impact 1.0
  title 'Check if Publish instances has been provisioned successful'
  desc 'Check publish provision state'
  describe ready do
    it { should have_all_publish_instances_been_successful_provision }
  end
end

control 'author-dispatcher-instances-provisioned-successful' do
  impact 1.0
  title 'Check if Author-Dispatcher instances has been provisioned successful'
  desc 'Check author-dispatcher provision state'
  describe ready do
    it { should have_all_author_dispatcher_instances_been_successful_provision }
  end
end

control 'publish-dispatcher-instances-provisioned-successful' do
  impact 1.0
  title 'Check if Publish-Dispatcher instances has been provisioned successful'
  desc 'Check publish-dispatcher provision state'
  describe ready do
    it { should have_all_publish_dispatcher_instances_been_successful_provision }
  end
end

control 'orchestrator-instances-provisioned-successful' do
  impact 1.0
  title 'Check if Orchestrator instance has been provisioned successful'
  desc 'Check orchestrator provision state'
  describe ready do
    it { should have_orchestrator_instances_been_successful_provision }
  end
end

control 'chaosmonkey-instances-provisioned-successful' do
  impact 1.0
  title 'Check if Chaosmonkey instance has been provisioned successful'
  desc 'Check chaosmonkey provision state'
  describe ready do
    it { should have_chaosmonkey_instances_been_successful_provision }
  end
end

control 'author-publish-dispatcher-instance-provisioned-successful' do
  impact 1.0
  title 'Check if Author-Publish-Dispatcher instance has been provisioned successful'
  desc 'Check author-publish-dispatcher provision state'
  describe ready do
    it { should have_author_publish_dispatcher_instance_been_successful_provision }
  end
end
