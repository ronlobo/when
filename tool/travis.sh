#!/bin/bash

# Copyright (c) 2015, the Dart project authors.  Please see the AUTHORS file
# for details. All rights reserved. Use of this source code is governed by a
# BSD-style license that can be found in the LICENSE file.

# Fast fail the script on failures.		
set -e

# Verify that the libraries are error free.
dartanalyzer --fatal-warnings \
  lib/when.dart \
  example/read_json_file.dart \
  test/when_test.dart

# Run the tests.
dart test/when_test.dart

# Install dart_coveralls; gather and send coverage data.
if [ "$COVERALLS_TOKEN" ]; then
  pub global activate dart_coveralls 0.1.11
  pub global run dart_coveralls report \
    --token $COVERALLS_TOKEN \
    --retry 2 \
    --exclude-test-files \
    test/when_test.dart
fi
