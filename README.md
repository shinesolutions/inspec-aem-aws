[![Build Status](https://img.shields.io/travis/shinesolutions/inspec-aem-aws.svg)](http://travis-ci.org/shinesolutions/inspec-aem-aws)

InSpec AEM-AWS
----------

An [InSpec](https://www.inspec.io) profile for checking AEM resources on AWS.

Usage
-----

Run profile directly from Chef Supermarket:

    inspec supermarket exec shinesolutions/aem-aws

Run profile directly from GitHub:

    inspec exec https://github.com/shinesolutions/inspec-aem-aws

Run all tests:

    make test

Run Readiness test:

    make test-readiness

Run Recovery test:

    make test-recovery

Run all tests with custom configuration file:

    INSPEC_AWS_CONF=some-aws.yaml make test
