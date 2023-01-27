#!/bin/sh

file=test/coverage_helper_test.dart
printf "// Helper file to make coverage work for all dart files\n" > $file
printf "// **************************************************************************\n" >> $file
printf "// Because of this: https://github.com/flutter/flutter/issues/27997#issue-410722816\n" >> $file
printf "// DO NOT EDIT THIS FILE USE: ./scripts/file_finder.sh\n" >> $file
printf "// **************************************************************************\n" >> $file
printf "\n" >> $file
printf "// ignore_for_file: unused_import, directives_ordering, eol_at_end_of_file\n" >> $file
find lib -type f \( -iname "*.dart" ! -iname "*.g.dart" ! -iname "*.freezed.dart" ! -iname "generated_plugin_registrant.dart" \) | cut -c4- | awk -v package="$1" '{printf "import '\''package:motis_mitfahr_app%s'\'';\n", $1}' >> $file
printf "\nvoid main(){}" >> $file