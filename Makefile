ci: clean deps lint

clean:
	rm -rf inspec.lock Gemfile.lock bin vendor

deps:
	gem install bundler --version=1.17.3
	bundle config --local path vendor/bundle
	bundle install --binstubs

lint:
	bundle exec rubocop Gemfile controls/ libraries/
	bundle exec yaml-lint .*.yml conf/*.yml

test-integration:
	inspec check .

test:
	inspec exec .

test-readiness: test-readiness-orchestrator test-readiness-author test-readiness-author-dispatcher test-readiness-publish test-readiness-publish-dispatcher test-readiness-chaosmonkey

test-readiness-with-disabled-chaosmonkey: test-readiness-orchestrator test-readiness-author test-readiness-author-dispatcher test-readiness-publish test-readiness-publish-dispatcher

test-provisioning: test-successful-provisioning-orchestrator test-successful-provisioning-author-primary test-successful-provisioning-author-standby test-successful-provisioning-author-dispatcher test-successful-provisioning-publish test-successful-provisioning-publish-dispatcher test-successful-provisioning-chaosmonkey

test-provisioning-with-disabled-chaosmonkey: test-successful-provisioning-orchestrator test-successful-provisioning-author-primary test-successful-provisioning-author-standby test-successful-provisioning-author-dispatcher test-successful-provisioning-publish test-successful-provisioning-publish-dispatcher

test-provisioning-readiness: test-successful-provisioning-orchestrator test-readiness-orchestrator test-successful-provisioning-author-primary test-successful-provisioning-author-standby test-readiness-author test-successful-provisioning-author-dispatcher test-readiness-author-dispatcher test-successful-provisioning-publish test-readiness-publish test-successful-provisioning-publish-dispatcher test-readiness-publish-dispatcher test-successful-provisioning-chaosmonkey test-readiness-chaosmonkey

test-provisioning-readiness-with-disabled-chaosmonkey: test-successful-provisioning-orchestrator test-readiness-orchestrator test-successful-provisioning-author-primary test-successful-provisioning-author-standby test-readiness-author test-successful-provisioning-author-dispatcher test-readiness-author-dispatcher test-successful-provisioning-publish test-readiness-publish test-successful-provisioning-publish-dispatcher test-readiness-publish-dispatcher

test-recovery: test-recovery-orchestrator test-recovery-author-dispatcher test-recovery-publish-dispatcher test-recovery-publish test-recovery-chaosmonkey

test-recovery-with-disabled-chaosmonkey: test-recovery-orchestrator test-recovery-author-dispatcher test-recovery-publish-dispatcher test-recovery-publish

test-recovery-author-dispatcher: terminate-random-author-dispatcher-instance recover-from-author-dispatcher-termination test-successful-provisioning-author-dispatcher

test-recovery-publish-dispatcher: terminate-random-publish-dispatcher-instance recover-from-publish-dispatcher-termination recover-from-publish-termination test-successful-provisioning-publish

test-recovery-publish: terminate-random-publish-instance recover-from-publish-termination test-successful-provisioning-publish recover-from-publish-dispatcher-termination test-successful-provisioning-publish-dispatcher

test-recovery-chaosmonkey: terminate-chaosmonkey-instance recover-from-chaosmonkey-termination test-successful-provisioning-chaosmonkey

test-recovery-orchestrator: terminate-orchestrator-instance recover-from-orchestrator-termination test-successful-provisioning-orchestrator

test-readiness-author:
	inspec exec . --show-progress --controls=\
	  author-instances-ready

test-readiness-publish:
	inspec exec . --show-progress --controls=\
	  publish-instances-ready

test-readiness-author-dispatcher:
	inspec exec . --show-progress --controls=\
	  author-dispatcher-instances-ready

test-readiness-publish-dispatcher:
	inspec exec . --show-progress --controls=\
	  publish-dispatcher-instances-ready

test-readiness-chaosmonkey:
	inspec exec . --show-progress --controls=\
	  chaosmonkey-instances-ready

test-readiness-orchestrator:
	inspec exec . --show-progress --controls=\
	  orchestrator-instances-ready

test-successful-provisioning-author:
	inspec exec . --show-progress --controls=\
	  author-instances-provisioned-successful

test-successful-provisioning-author-primary:
	inspec exec . --show-progress --controls=\
	  author-primary-instance-provisioned-successful

test-successful-provisioning-author-standby:
	inspec exec . --show-progress --controls=\
	  author-standby-instance-provisioned-successful

test-successful-provisioning-publish:
	inspec exec . --show-progress --controls=\
	  publish-instances-provisioned-successful

test-successful-provisioning-author-dispatcher:
	inspec exec . --show-progress --controls=\
	  author-dispatcher-instances-provisioned-successful

test-successful-provisioning-publish-dispatcher:
	inspec exec . --show-progress --controls=\
	  publish-dispatcher-instances-provisioned-successful

test-successful-provisioning-orchestrator:
	inspec exec . --show-progress --controls=\
	  orchestrator-instances-provisioned-successful

test-successful-provisioning-chaosmonkey:
	inspec exec . --show-progress --controls=\
	  chaosmonkey-instances-provisioned-successful

test-successful-provisioning-author-publish-dispatcher:
	inspec exec . --show-progress --controls=\
	  author-publish-dispatcher-instance-provisioned-successful

terminate-author-primary:
	inspec exec . --show-progress --controls=\
	  terminate-author-primary-instance

terminate-random-author-dispatcher-instance:
	inspec exec . --show-progress --controls=\
	  terminate-random-author-dispatcher-instance

recover-from-author-dispatcher-termination:
	inspec exec . --show-progress --controls=\
	  recover-from-author-dispatcher-termination

terminate-random-publish-dispatcher-instance:
	inspec exec . --show-progress --controls=\
		terminate-random-publish-dispatcher-instance

recover-from-publish-dispatcher-termination:
	inspec exec . --show-progress --controls=\
		recover-from-publish-dispatcher-termination

terminate-random-publish-instance:
	inspec exec . --show-progress --controls=\
		terminate-random-publish-instance

recover-from-publish-termination:
	inspec exec . --show-progress --controls=\
		recover-from-publish-termination

terminate-chaosmonkey-instance:
	inspec exec . --show-progress --controls=\
		terminate-chaosmonkey-instance

recover-from-chaosmonkey-termination:
	inspec exec . --show-progress --controls=\
		recover-from-chaosmonkey-termination

terminate-orchestrator-instance:
	inspec exec . --show-progress --controls=\
		terminate-orchestrator-instance

recover-from-orchestrator-termination:
	inspec exec . --show-progress --controls=\
		recover-from-orchestrator-termination

test-acceptance-full-set:
	inspec exec . --show-progress --controls=\
	  full-set-cloudwatch-alarms-exists

test-acceptance-author-primary:
	inspec exec . --show-progress --controls=\
		author-primary-cloudwatch-ec2-metrics-exist \
		author-primary-cloudwatch-collectd-generic-metric-exist \
		author-primary-cloudwatch-loggroups-exist \
		author-primary-cloudwatch-log-streams-exist \
		author-primary-generic-cloudwatch-loggroups-exist \
		author-primary-generic-cloudwatch-log-streams-exist \
		author-primary-finished-provisioning

test-acceptance-author-standby:
	inspec exec . --show-progress --controls=\
		author-standby-cloudwatch-ec2-metrics-exist \
		author-standby-cloudwatch-collectd-generic-metric-exist \
		author-standby-cloudwatch-collectd-sync-metric-exist \
		author-standby-cloudwatch-loggroups-exist \
		author-standby-cloudwatch-log-streams-exist \
		author-standby-generic-cloudwatch-loggroups-exist \
		author-standby-generic-cloudwatch-log-streams-exist \
		author-standby-finished-provisioning

test-acceptance-publish:
	inspec exec . --show-progress --controls=\
		publish-cloudwatch-ec2-metrics-exist \
		publish-cloudwatch-contentHealthCheck-metric-exist \
		publish-cloudwatch-collectd-generic-metric-exist \
		publish-generic-cloudwatch-loggroups-exist \
		publish-generic-cloudwatch-log-streams-exist \
		publish-cloudwatch-loggroups-exist \
		publish-cloudwatch-log-streams-exist \
		publish-finished-provisioning

test-acceptance-author-dispatcher:
	inspec exec . --show-progress --controls=\
		author-dispatcher-cloudwatch-ec2-metrics-exist \
		author-dispatcher-cloudwatch-loggroups-exist \
		author-dispatcher-cloudwatch-log-streams-exist \
		author-dispatcher-generic-cloudwatch-log-streams-exist \
		author-dispatcher-generic-cloudwatch-loggroups-exist \
		author-dispatcher-finished-provisioning

test-acceptance-publish-dispatcher:
	inspec exec . --show-progress --controls=\
		publish-dispatcher-cloudwatch-ec2-metrics-exist \
		publish-dispatcher-cloudwatch-loggroups-exist \
		publish-dispatcher-cloudwatch-log-streams-exist \
		publish-dispatcher-generic-cloudwatch-loggroups-exist \
		publish-dispatcher-generic-cloudwatch-log-streams-exist \
		publish-dispatcher-finished-provisioning

test-acceptance-orchestrator:
	inspec exec . --show-progress --controls=\
		orchestrator-cloudwatch-ec2-metrics-exist \
		orchestrator-cloudwatch-loggroups-exist \
		orchestrator-cloudwatch-log-streams-exist \
		orchestrator-generic-cloudwatch-loggroups-exist \
		orchestrator-generic-cloudwatch-log-streams-exist \
		orchestrator-finished-provisioning

test-contenthealthcheck-alarm-state:
	inspec exec . --show-progress --controls=\
	  publish-wait-until-contenthealthcheck-alarm-ok

release:
	rtk release

.PHONY: ci clean deps lint test release
