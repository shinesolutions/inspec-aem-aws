### 0.11.7
* Add feature to terminate author-primary instance
* Add readiness check for AEM OpenCloud components Chaos Monkey & Orchestrator
* Add recovery testing for AEM OpenCloud components Chaos Monkey & Orchestrator

### 0.11.6
* Add new checks for un/scheduling live-snapshots shinesolutions/aem-aws-stack-builder#212

### 0.11.5
* Remove test stack prefix in default config

### 0.11.4
* Fix bug in loading retry values from configuration file #11
* Introduce dependencies bundle vendoring

### 0.11.3
* Remove default profile, move inspec check out of lint to avoid IO during CI run

### 0.11.2
* Content health check should fail when there is no instance

### 0.11.1
* Add check for alarm states
* Add Checks for alarm state of contentHealthCheck

### 0.11.0
* Add acceptance test support

### 0.10.0
* Set InSpec version to ~> 1.51.6 in order to use aws-sdk 3
* Drop support for Ruby 2.2

### 0.9.0
* Initial version
