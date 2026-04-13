#!/bin/bash

# =============================================================================
# Test Runner (AI Agent Optimized) — Framework Delegator
# =============================================================================
# Stable entry point for running tests. Delegates to the framework-specific
# runner configured via FRAMEWORK in .ai/project/scripts.env.
#
# To add support for a new framework:
#   1. Create .ai/frameworks/<name>/run_tests.sh
#   2. Set FRAMEWORK=<name> in .ai/project/scripts.env
#
# All flags and arguments are passed through to the framework runner.
# See the framework-specific script for supported options.
# =============================================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Load project-specific config
ENV_FILE="$SCRIPT_DIR/../project/scripts.env"
if [ -f "$ENV_FILE" ]; then
    # shellcheck source=../project/scripts.env
    source "$ENV_FILE"
fi

FRAMEWORK="${FRAMEWORK:-react-native}"
FRAMEWORK_SCRIPT="$SCRIPT_DIR/../frameworks/$FRAMEWORK/run_tests.sh"

if [ ! -f "$FRAMEWORK_SCRIPT" ]; then
    echo "Error: No test runner found for framework '$FRAMEWORK'"
    echo "Expected: $FRAMEWORK_SCRIPT"
    echo "Create the script or update FRAMEWORK in .ai/project/scripts.env"
    exit 1
fi

exec bash "$FRAMEWORK_SCRIPT" "$@"
