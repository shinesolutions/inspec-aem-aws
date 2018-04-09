ci: tools deps lint

clean:
	rm Gemfile.lock inspec.lock

deps:
	bundle install

lint:
	inspec check .
	rubocop

test:
	inspec exec .

test-ready:
	inspec exec . --show-progress --controls=\
	  author-instances-ready \
	  publish-instances-ready \
	  author-dispatcher-instances-ready \
	  publish-dispatcher-instances-ready

test-recovery:
	inspec exec . --show-progress --controls=\
	  terminate-random-author-dispatcher-instance \
		recover-from-author-dispatcher-termination \
		terminate-random-publish-instance \
		recover-from-publish-termination \
		terminate-random-publish-dispatcher-instance \
		recover-from-publish-dispatcher-termination \

tools:
	gem install bundler

.PHONY: ci clean deps lint test tools
