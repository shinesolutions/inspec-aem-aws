# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Add new configuration parameter `aws.region`[#42]

### Changed
- Increase readiness test retry to 6h
- Increase recovery test retry to 6h

### Fixed
- Fix typo in elb readiness check

## [1.9.0] - 2020-02-17
### Changed
- Makefile clean target also removes Gemfile.lock file

### Fixed
- Fixed outdated Gemfile.lock file

## [1.8.0] - 2020-01-14
### Changed
- Update CPU and Disk alarm names to be explicit about high load

## [1.7.0] - 2020-01-14
### Changed
- Rename alarms list to use <severity>-<component>-<alarm> format

## [1.6.0] - 2020-01-13
### Added
- Add disk space, cpu, and memory to AEM Full-Set alarms list

### Changed
- Add Critical and Warning prefix to AEM Full-Set alarms list

## [1.5.0] - 2019-11-26
### Fixed
- Fixed inspec control `cloudwatch-component-log-streams-exist` [#38]

## [1.4.0] - 2019-09-07
### Removed
- Remove DiskReadBytes, DiskReadOps, DiskWriteBytes, DiskWriteOps due to restrictive instance type requirement [#37]

## [1.3.0] - 2019-08-14
### Changed
- Upgrade ruby_aem_aws to 1.4.0

## [1.2.0] - 2019-08-14
### Fixed
- Fixed syntax error in method successful_provisioned_component [#33]

## [1.1.0] - 2019-06-08
### Added
- Add new make target to check FS stacks with disabled chaos monkey shinesolutions/aem-aws-stack-builder#290
- Add new make target to support recovery test for FS stacks with disabled chaos monkey [#32]
- Add skip_component_failed_state for provisioning check [#34]

### Removed
- Remove ruby_aem dependency, no longer needed

## [1.0.0] - 2019-05-23

## [0.16.0] - 2019-05-23
### Added
- Add make target to check provisioning state
- Add make target to check provisioning state & readiness

### Changed
- Changed recovery make target to test orchestrator first
- Undo changes to the readiness make target

## [0.15.0] - 2019-05-23
### Added
- New Checks for checking EC2 Tag ComponentInitStatus

### Changed
- Extend existing readiness check to check for the ec2 tag ComponentInitStatus
- Add new Make targets to check provisioning state
- Restructured Make targets for readiness check
- Upgrade ruby_aem_aws to 1.3.0

## [0.14.1] - 2019-05-18
### Fixed
- Fix frozen string literal Rubocop violations

## [0.14.0] - 2019-04-23
### Changed
- Upgrade ruby_aem_aws to 1.2.1

### Removed
- Removed acceptance test for AEM logfiles access.log & request.log [#25]

### Fixed
- Fixed make targets for recovery test [#20] [#21]
- Fixed failing recovery test for Chaosmonkey & Orchestrator [#22]

## [0.13.0] - 2019-04-03
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

## 0.9.0 - 2018-05-20
### Added
- Initial version

[#20]: https://github.com/shinesolutions/inspec-aem-aws/issues/20
[#21]: https://github.com/shinesolutions/inspec-aem-aws/issues/21
[#22]: https://github.com/shinesolutions/inspec-aem-aws/issues/22
[#25]: https://github.com/shinesolutions/inspec-aem-aws/issues/25
[#32]: https://github.com/shinesolutions/inspec-aem-aws/issues/32
[#33]: https://github.com/shinesolutions/inspec-aem-aws/issues/33
[#34]: https://github.com/shinesolutions/inspec-aem-aws/issues/34
[#37]: https://github.com/shinesolutions/inspec-aem-aws/issues/37
[#38]: https://github.com/shinesolutions/inspec-aem-aws/issues/38

[Unreleased]: https://github.com/shinesolutions/inspec-aem-aws/compare/1.9.0...HEAD
[1.9.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/1.8.0...1.9.0
[1.8.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/1.7.0...1.8.0
[1.7.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/1.6.0...1.7.0
[1.6.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/1.5.0...1.6.0
[1.5.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/1.4.0...1.5.0
[1.4.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/1.3.0...1.4.0
[1.3.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/1.2.0...1.3.0
[1.2.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/1.1.0...1.2.0
[1.1.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/1.0.0...1.1.0
[1.0.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.16.0...1.0.0
[0.16.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.15.0...0.16.0
[0.15.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.14.1...0.15.0
[0.14.1]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.14.0...0.14.1
[0.14.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.13.0...0.14.0
[0.13.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.12.0...0.13.0
[0.12.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.11.6...0.12.0
[0.11.6]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.11.5...0.11.6
[0.11.5]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.11.4...0.11.5
[0.11.4]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.11.3...0.11.4
[0.11.3]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.11.2...0.11.3
[0.11.2]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.11.1...0.11.2
[0.11.1]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.11.0...0.11.1
[0.11.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.10.0...0.11.0
[0.10.0]: https://github.com/shinesolutions/inspec-aem-aws/compare/0.9.0...0.10.0
