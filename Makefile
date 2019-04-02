ci: deps lint

clean:
	rm *.lock bin vendor

deps:
	gem install bundler
	bundle config --local path vendor/bundle
	bundle install --binstubs

lint:
	bundle exec rubocop Gemfile controls/ libraries/

test-integration:
	bundle exec inspec check .

test:
	bundle exec inspec exec .

test-readiness:
	bundle exec inspec exec . --show-progress --controls=\
	  author-instances-ready \
	  publish-instances-ready \
	  author-dispatcher-instances-ready \
	  publish-dispatcher-instances-ready \
	  chaosmonkey-instances-ready \
	  orchestrator-instances-ready

terminate-author-primary:
	bundle exec inspec exec . --show-progress --controls=\
	  terminate-author-primary-instance

test-recovery:
	bundle exec inspec exec . --show-progress --controls=\
	  terminate-random-author-dispatcher-instance \
		recover-from-author-dispatcher-termination \
		terminate-random-publish-dispatcher-instance \
		recover-from-publish-dispatcher-termination \
		recover-from-publish-termination \
		terminate-random-publish-instance \
		recover-from-publish-termination \
		recover-from-publish-dispatcher-termination \
		terminate-random-chaosmonkey-dispatcher-instance \
		recover-from-chaosmonkey-dispatcher-termination \
		terminate-random-orchestrator-dispatcher-instance \
		recover-from-orchestrator-dispatcher-termination

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

test-acceptance-author-dispatcher:
	bundle exec inspec exec . --show-progress --controls=\
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

.PHONY: ci clean deps lint test
