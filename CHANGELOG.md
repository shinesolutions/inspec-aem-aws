# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Modify test make targets to execute inspec binary from the PATH instead of via bundler
- Upgrade ruby_aem to 2.5.1, change deps versions to be exact

## [0.12.0] - 2019-04-01

### Added
- Add feature to terminate author-primary instance
- Add readiness check for AEM OpenCloud components Chaos Monkey & Orchestrator
- Add recovery testing for AEM OpenCloud components Chaos Monkey & Orchestrator

## [0.11.6] - 2018-11-05

### Added
- Add new checks for un/scheduling live-snapshots shinesolutions/aem-aws-stack-builder#212

## [0.11.5] - 2018-10-10

### Removed
- Remove test stack prefix in default config

## [0.11.4] - 2018-10-10

### Added
- Introduce dependencies bundle vendoring

## [0.11.3] - 2018-06-14

### Removed
- Remove default profile, move inspec check out of lint to avoid IO during CI run

## [0.11.2] - 2018-06-13

### Changed
- Content health check should fail when there is no instance

## [0.11.1] - 2018-06-01

### Added
- Add check for alarm states
- Add Checks for alarm state of contentHealthCheck

## [0.11.0] - 2018-05-31

### Added
- Add acceptance test support

## [0.10.0] - 2018-05-31

### Changed
- Set InSpec version to ~> 1.51.6 in order to use aws-sdk 3
- Drop support for Ruby 2.2

## [0.9.0] - 2018-05-20

### Added
- Initial version

[Unreleased]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.11.6...HEAD
[0.11.6]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.11.5...0.11.6
[0.11.5]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.11.4...0.11.5
[0.11.4]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.11.3...0.11.4
[0.11.3]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.11.2...0.11.3
[0.11.2]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.11.1...0.11.2
[0.11.1]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.11.0...0.11.1
[0.11.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.10.0...0.11.0
[0.10.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.9.0...0.10.0
