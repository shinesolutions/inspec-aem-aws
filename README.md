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

    INSPEC_AEM_AWS_CONF=some-aws.yaml make test

Until issue [#10](https://github.com/shinesolutions/inspec-aem-aws/issues/10) is resolved, `aws_profile` needs to be passed as environment variable:

    aws_profile=default INSPEC_AEM_AWS_CONF=some-aws.yaml make test
