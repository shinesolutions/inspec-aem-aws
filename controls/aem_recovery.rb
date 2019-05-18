# frozen_string_literal: true

control 'terminate-author-primary-instance' do
  impact 1.0
  title 'Terminate AEM Author Primary instance'
  desc 'Terminate AEM Author Primary instance'
  describe recovery do
    it { should have_terminated_author_primary_instance }
  end
end

control 'terminate-random-author-dispatcher-instance' do
  impact 1.0
  title 'Terminate a random Author Dispatcher instance'
  desc 'Terminate a random Author Dispatcher instance'
  describe recovery do
    it { should have_terminated_a_random_author_dispatcher_instance }
  end
end

control 'recover-from-author-dispatcher-termination' do
  impact 1.0
  title 'Recover from Author Dispatcher instance termination'
  desc 'Recover from Author Dispatcher instance termination'
  describe recovery do
    it { should be_able_to_recover_from_author_dispatcher_termination }
  end
end

control 'terminate-random-publish-instance' do
  impact 1.0
  title 'Terminate a random Publish instance'
  desc 'Terminate a random Publish instance'
  describe recovery do
    it { should have_terminated_a_random_publish_instance }
  end
end

control 'recover-from-publish-termination' do
  impact 1.0
  title 'Recover from Publish instance termination'
  desc 'Recover from Publish instance termination'
  describe recovery do
    it { should be_able_to_recover_from_publish_termination }
  end
end

control 'terminate-random-publish-dispatcher-instance' do
  impact 1.0
  title 'Terminate a random Publish Dispatcher instance'
  desc 'Terminate a random Publish Dispatcher instance'
  describe recovery do
    it { should have_terminated_a_random_publish_dispatcher_instance }
  end
end

control 'recover-from-publish-dispatcher-termination' do
  impact 1.0
  title 'Recover from Publish Dispatcher instance termination'
  desc 'Recover from Publish Dispatcher instance termination'
  describe recovery do
    it { should be_able_to_recover_from_publish_dispatcher_termination }
  end
end

control 'terminate-orchestrator-instance' do
  impact 1.0
  title 'Terminate a random Orchestrator instance'
  desc 'Terminate a random Orchestrator instance'
  describe recovery do
    it { should have_terminated_a_orchestrator_instance }
  end
end

control 'recover-from-orchestrator-termination' do
  impact 1.0
  title 'Recover from Orchestrator instance termination'
  desc 'Recover from Orchestrator instance termination'
  describe recovery do
    it { should be_able_to_recover_from_orchestrator_termination }
  end
end

control 'terminate-chaosmonkey-instance' do
  impact 1.0
  title 'Terminate the Chaosmonkey instance'
  desc 'Terminate the Chaosmonkey instance'
  describe recovery do
    it { should have_terminated_a_chaosmonkey_instance }
  end
end

control 'recover-from-chaosmonkey-termination' do
  impact 1.0
  title 'Recover from Chaosmonkey instance termination'
  desc 'Recover from Chaosmonkey instance termination'
  describe recovery do
    it { should be_able_to_recover_from_chaosmonkey_termination }
  end
end
