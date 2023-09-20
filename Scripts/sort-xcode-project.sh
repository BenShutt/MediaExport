#!/usr/bin/env bash

#
# Script: sort-xcode-project.sh
# Usage: ./sort-xcode-project.sh
#
# Sorts the Xcode project file alphabetically.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# ============================== Variables ==============================

# Directory of this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# (Relative) path to the perl script
PERL_SCRIPT="${SCRIPT_DIR}/exe-sort-xcode-project.pl"

# (Relative) path to the Xcode project file
PROJECT_FILE="${SCRIPT_DIR}/../MediaExport.xcodeproj/project.pbxproj"

# ============================== Main ==============================

# Execute script passing the project file
perl "${PERL_SCRIPT}" "${PROJECT_FILE}"

