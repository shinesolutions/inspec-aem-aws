ci: clean deps lint

clean:
	rm -rf inspec.lock Gemfile.lock bin vendor

deps:
	gem install bundler --version=4.0.22
	rm -rf .bundle
	bundle config set --local path vendor/bundle
	bundle install
	bundle binstubs --all

lint:
	bundle exec rubocop Gemfile controls/ libraries/
	bundle exec yaml-lint .*.yml conf/*.yml
	jsonlint .rtk.json
	yamllint *.yml conf/*.yml

test-integration:
	bundle exec inspec check .

test:
	bundle exec inspec exec .

test-readiness: test-readiness-orchestrator test-readiness-author test-readiness-author-dispatcher test-readiness-publish test-readiness-publish-dispatcher test-readiness-chaosmonkey

test-readiness-with-enabled-preview-architecture: test-readiness-orchestrator test-readiness-author test-readiness-author-dispatcher test-readiness-publish test-readiness-publish-dispatcher test-readiness-preview-publish test-readiness-preview-publish-dispatcher test-readiness-chaosmonkey

test-readiness-with-disabled-chaosmonkey: test-readiness-orchestrator test-readiness-author test-readiness-author-dispatcher test-readiness-publish test-readiness-publish-dispatcher

test-readiness-with-disabled-chaosmonkey-with-enabled-preview-architecture: test-readiness-orchestrator test-readiness-author test-readiness-author-dispatcher test-readiness-publish test-readiness-publish-dispatcher test-readiness-preview-publish test-readiness-preview-publish-dispatcher

test-provisioning: test-successful-provisioning-orchestrator test-successful-provisioning-author-primary test-successful-provisioning-author-standby test-successful-provisioning-author-dispatcher test-successful-provisioning-publish test-successful-provisioning-publish-dispatcher test-successful-provisioning-chaosmonkey

test-provisioning-with-enabled-preview-architecture: test-successful-provisioning-orchestrator test-successful-provisioning-author-primary test-successful-provisioning-author-standby test-successful-provisioning-author-dispatcher test-successful-provisioning-publish test-successful-provisioning-publish-dispatcher test-successful-provisioning-preview-publish test-successful-provisioning-preview-publish-dispatcher test-successful-provisioning-chaosmonkey

test-provisioning-with-disabled-chaosmonkey: test-successful-provisioning-orchestrator test-successful-provisioning-author-primary test-successful-provisioning-author-standby test-successful-provisioning-author-dispatcher test-successful-provisioning-publish test-successful-provisioning-publish-dispatcher

test-provisioning-with-disabled-chaosmonkey-with-enabled-preview-architecture: test-successful-provisioning-orchestrator test-successful-provisioning-author-primary test-successful-provisioning-author-standby test-successful-provisioning-author-dispatcher test-successful-provisioning-publish test-successful-provisioning-publish-dispatcher test-successful-provisioning-preview-publish test-successful-provisioning-preview-publish-dispatcher

test-provisioning-readiness: test-successful-provisioning-orchestrator test-readiness-orchestrator test-successful-provisioning-author-primary test-successful-provisioning-author-standby test-readiness-author test-successful-provisioning-author-dispatcher test-readiness-author-dispatcher test-successful-provisioning-publish test-readiness-publish test-successful-provisioning-publish-dispatcher test-readiness-publish-dispatcher test-successful-provisioning-chaosmonkey test-readiness-chaosmonkey

test-provisioning-readiness-with-enabled-preview-architecture: test-successful-provisioning-orchestrator test-readiness-orchestrator test-successful-provisioning-author-primary test-successful-provisioning-author-standby test-readiness-author test-successful-provisioning-author-dispatcher test-readiness-author-dispatcher test-successful-provisioning-publish test-readiness-publish test-successful-provisioning-publish-dispatcher test-readiness-publish-dispatcher test-successful-provisioning-preview-publish test-readiness-preview-publish test-successful-provisioning-preview-publish-dispatcher test-readiness-preview-publish-dispatcher test-successful-provisioning-chaosmonkey test-readiness-chaosmonkey

test-provisioning-readiness-with-disabled-chaosmonkey: test-successful-provisioning-orchestrator test-readiness-orchestrator test-successful-provisioning-author-primary test-successful-provisioning-author-standby test-readiness-author test-successful-provisioning-author-dispatcher test-readiness-author-dispatcher test-successful-provisioning-publish test-readiness-publish test-successful-provisioning-publish-dispatcher test-readiness-publish-dispatcher

test-provisioning-readiness-with-disabled-chaosmonkey-with-enabled-preview-architecture: test-successful-provisioning-orchestrator test-readiness-orchestrator test-successful-provisioning-author-primary test-successful-provisioning-author-standby test-readiness-author test-successful-provisioning-author-dispatcher test-readiness-author-dispatcher test-successful-provisioning-publish test-readiness-publish test-successful-provisioning-publish-dispatcher test-readiness-publish-dispatcher test-successful-provisioning-preview-publish test-readiness-preview-publish test-successful-provisioning-preview-publish-dispatcher test-readiness-preview-publish-dispatcher 

test-recovery: test-recovery-orchestrator test-recovery-author-dispatcher test-recovery-publish-dispatcher test-recovery-publish test-recovery-chaosmonkey

test-recovery-with-enabled-preview-architecture: test-recovery-orchestrator test-recovery-author-dispatcher test-recovery-publish-dispatcher test-recovery-publish test-recovery-preview-publish-dispatcher test-recovery-preview-publish test-recovery-chaosmonkey

test-recovery-with-disabled-chaosmonkey: test-recovery-orchestrator test-recovery-author-dispatcher test-recovery-publish-dispatcher test-recovery-publish

test-recovery-with-disabled-chaosmonkey-with-enabled-preview-architecture: test-recovery-orchestrator test-recovery-author-dispatcher test-recovery-publish-dispatcher test-recovery-publish test-recovery-preview-publish-dispatcher test-recovery-preview-publish

test-readiness-author:
	bundle exec inspec exec . --show-progress --controls=\
	  author-instances-ready

test-readiness-publish:
	bundle exec inspec exec . --show-progress --controls=\
	  publish-instances-ready

test-readiness-preview-publish:
	bundle exec inspec exec . --show-progress --controls=\
	  preview-publish-instances-ready

test-readiness-author-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
	  author-dispatcher-instances-ready

test-readiness-publish-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
	  publish-dispatcher-instances-ready

test-readiness-preview-publish-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
	  preview-publish-dispatcher-instances-ready

test-readiness-chaosmonkey:
	bundle exec inspec exec . --show-progress --controls=\
	  chaosmonkey-instances-ready

test-readiness-orchestrator:
	bundle exec inspec exec . --show-progress --controls=\
	  orchestrator-instances-ready

test-successful-provisioning-author:
	bundle exec inspec exec . --show-progress --controls=\
	  author-instances-provisioned-successful

test-successful-provisioning-author-primary:
	bundle exec inspec exec . --show-progress --controls=\
	  author-primary-instance-provisioned-successful

test-successful-provisioning-author-standby:
	bundle exec inspec exec . --show-progress --controls=\
	  author-standby-instance-provisioned-successful

test-successful-provisioning-publish:
	bundle exec inspec exec . --show-progress --controls=\
	  publish-instances-provisioned-successful

test-successful-provisioning-preview-publish:
	bundle exec inspec exec . --show-progress --controls=\
	  preview-publish-instances-provisioned-successful

test-successful-provisioning-author-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
	  author-dispatcher-instances-provisioned-successful

test-successful-provisioning-publish-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
	  publish-dispatcher-instances-provisioned-successful

test-successful-provisioning-preview-publish-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
	  preview-publish-dispatcher-instances-provisioned-successful

test-successful-provisioning-orchestrator:
	bundle exec inspec exec . --show-progress --controls=\
	  orchestrator-instances-provisioned-successful

test-successful-provisioning-chaosmonkey:
	bundle exec inspec exec . --show-progress --controls=\
	  chaosmonkey-instances-provisioned-successful

test-successful-provisioning-author-publish-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
	  author-publish-dispatcher-instance-provisioned-successful

terminate-author-primary:
	bundle exec inspec exec . --show-progress --controls=\
	  terminate-author-primary-instance

test-recovery-author-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
	  terminate-random-author-dispatcher-instance \
		recover-from-author-dispatcher-termination

test-recovery-publish-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
		terminate-random-publish-dispatcher-instance \
		recover-from-publish-dispatcher-termination
	bundle exec inspec exec . --show-progress --controls=\
		recover-from-publish-termination

test-recovery-preview-publish-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
		terminate-random-preview-publish-dispatcher-instance \
		recover-from-preview-publish-dispatcher-termination
	bundle exec inspec exec . --show-progress --controls=\
		recover-from-preview-publish-termination

test-recovery-publish:
	bundle exec inspec exec . --show-progress --controls=\
		terminate-random-publish-instance \
		recover-from-publish-termination
	bundle exec inspec exec . --show-progress --controls=\
		recover-from-publish-dispatcher-termination

test-recovery-preview-publish:
	bundle exec inspec exec . --show-progress --controls=\
		terminate-random-preview-publish-instance \
		recover-from-preview-publish-termination
	bundle exec inspec exec . --show-progress --controls=\
		recover-from-preview-publish-dispatcher-termination

test-recovery-chaosmonkey:
	bundle exec inspec exec . --show-progress --controls=\
		terminate-chaosmonkey-instance \
		recover-from-chaosmonkey-termination

test-recovery-orchestrator:
	bundle exec inspec exec . --show-progress --controls=\
		terminate-orchestrator-instance \
		recover-from-orchestrator-termination

test-acceptance-full-set:
	bundle exec inspec exec . --show-progress --controls=\
	  full-set-cloudwatch-alarms-exists

test-acceptance-author-primary:
	bundle exec inspec exec . --show-progress --controls=\
		author-primary-cloudwatch-ec2-metrics-exist \
		author-primary-cloudwatch-collectd-generic-metric-exist \
		author-primary-cloudwatch-loggroups-exist \
		author-primary-cloudwatch-log-streams-exist \
		author-primary-generic-cloudwatch-loggroups-exist \
		author-primary-generic-cloudwatch-log-streams-exist \
		author-primary-finished-provisioning

test-acceptance-author-standby:
	bundle exec inspec exec . --show-progress --controls=\
		author-standby-cloudwatch-ec2-metrics-exist \
		author-standby-cloudwatch-collectd-generic-metric-exist \
		author-standby-cloudwatch-collectd-sync-metric-exist \
		author-standby-cloudwatch-loggroups-exist \
		author-standby-cloudwatch-log-streams-exist \
		author-standby-generic-cloudwatch-loggroups-exist \
		author-standby-generic-cloudwatch-log-streams-exist \
		author-standby-finished-provisioning

test-acceptance-publish:
	bundle exec inspec exec . --show-progress --controls=\
		publish-cloudwatch-ec2-metrics-exist \
		publish-cloudwatch-contentHealthCheck-metric-exist \
		publish-cloudwatch-collectd-generic-metric-exist \
		publish-generic-cloudwatch-loggroups-exist \
		publish-generic-cloudwatch-log-streams-exist \
		publish-cloudwatch-loggroups-exist \
		publish-cloudwatch-log-streams-exist \
		publish-finished-provisioning

test-acceptance-preview-publish:
	bundle exec inspec exec . --show-progress --controls=\
		preview-publish-cloudwatch-ec2-metrics-exist \
		preview-publish-cloudwatch-collectd-generic-metric-exist \
		preview-publish-generic-cloudwatch-loggroups-exist \
		preview-publish-generic-cloudwatch-log-streams-exist \
		preview-publish-cloudwatch-loggroups-exist \
		preview-publish-cloudwatch-log-streams-exist \
		preview-publish-finished-provisioning

test-acceptance-author-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
		author-dispatcher-cloudwatch-ec2-metrics-exist \
		author-dispatcher-cloudwatch-loggroups-exist \
		author-dispatcher-cloudwatch-log-streams-exist \
		author-dispatcher-generic-cloudwatch-log-streams-exist \
		author-dispatcher-generic-cloudwatch-loggroups-exist \
		author-dispatcher-finished-provisioning

test-acceptance-publish-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
		publish-dispatcher-cloudwatch-ec2-metrics-exist \
		publish-dispatcher-cloudwatch-loggroups-exist \
		publish-dispatcher-cloudwatch-log-streams-exist \
		publish-dispatcher-generic-cloudwatch-loggroups-exist \
		publish-dispatcher-generic-cloudwatch-log-streams-exist \
		publish-dispatcher-finished-provisioning

test-acceptance-preview-publish-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
		preview-publish-dispatcher-cloudwatch-ec2-metrics-exist \
		preview-publish-dispatcher-cloudwatch-loggroups-exist \
		preview-publish-dispatcher-cloudwatch-log-streams-exist \
		preview-publish-dispatcher-generic-cloudwatch-loggroups-exist \
		preview-publish-dispatcher-generic-cloudwatch-log-streams-exist \
		preview-publish-dispatcher-finished-provisioning

test-acceptance-orchestrator:
	bundle exec inspec exec . --show-progress --controls=\
		orchestrator-cloudwatch-ec2-metrics-exist \
		orchestrator-cloudwatch-loggroups-exist \
		orchestrator-cloudwatch-log-streams-exist \
		orchestrator-generic-cloudwatch-loggroups-exist \
		orchestrator-generic-cloudwatch-log-streams-exist \
		orchestrator-finished-provisioning

test-contenthealthcheck-alarm-state:
	bundle exec inspec exec . --show-progress --controls=\
	  publish-wait-until-contenthealthcheck-alarm-ok

release-major:
	rtk release --release-increment-type major

release-minor:
	rtk release --release-increment-type minor

release-patch:
	rtk release --release-increment-type patch

release: release-minor

.PHONY: ci clean deps lint test release release-major release-minor release-patch
