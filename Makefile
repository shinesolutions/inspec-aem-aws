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

tools:
	gem install bundler

.PHONY: ci clean deps lint test tools
