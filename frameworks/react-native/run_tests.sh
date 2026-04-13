#!/bin/bash

# =============================================================================
# Test Runner: React Native / Jest (AI Agent Optimized)
# =============================================================================
# Framework-specific runner for React Native projects using Jest.
# Invoked via .ai/scripts/run_tests.sh — do not call directly.
#
# Default behavior (no flags):
#   - Minimal output (no colors, suppressed console.log)
#   - Stops on first failure (--bail)
#   - Clean CI-style output
#
# Usage (via .ai/scripts/run_tests.sh):
#   ./run_tests.sh                    # Run all tests (minimal output)
#   ./run_tests.sh <path>             # Run specific test file or pattern
#   ./run_tests.sh --verbose          # Full output with colors (for humans)
#   ./run_tests.sh --watch            # Run tests in watch mode
#   ./run_tests.sh --coverage         # Run tests with coverage report
#   ./run_tests.sh --changed          # Run tests related to changed files
#   ./run_tests.sh --update           # Update snapshots
#   ./run_tests.sh --no-bail          # Run all tests even if some fail
#   ./run_tests.sh --json             # Output results as JSON
#
# Examples:
#   ./run_tests.sh src/features/auth/login/LoginScreen.test.tsx
#   ./run_tests.sh --testPathPattern="cart"
#   ./run_tests.sh --verbose --no-bail  # Human debugging: full output, all tests
#   ./run_tests.sh --json > results.json
# =============================================================================

set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Navigate to the project root (three levels up from .ai/frameworks/<name>)
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

# Load project-specific config
ENV_FILE="$SCRIPT_DIR/../../project/scripts.env"
if [ -f "$ENV_FILE" ]; then
    # shellcheck source=../../project/scripts.env
    source "$ENV_FILE"
fi

# The directory containing package.json and jest config (configurable via scripts.env)
APP_DIR="$PROJECT_ROOT/${TEST_ROOT:-.}"

# Verify we're in the right place
if [ ! -f "$APP_DIR/package.json" ]; then
    echo "Error: Could not find package.json in $APP_DIR"
    echo "Please ensure you're running this script from the correct project."
    exit 1
fi

if [ ! -f "$APP_DIR/jest.config.js" ]; then
    echo "Error: Could not find jest.config.js in $APP_DIR"
    exit 1
fi

# Change to app directory
cd "$APP_DIR"

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "Warning: node_modules not found. Running yarn install..."
    yarn install
fi

# Default Jest options
JEST_OPTS=""

# Parse arguments
# Defaults optimized for AI agents: minimal output, bail on first failure
RUN_WATCH=false
RUN_COVERAGE=false
RUN_CHANGED=false
UPDATE_SNAPSHOTS=false
RUN_VERBOSE=false
RUN_JSON=false
RUN_BAIL=true
RUN_SILENT=true
TEST_PATH=""
EXTRA_ARGS=""

for arg in "$@"; do
    case $arg in
        --watch|-w)
            RUN_WATCH=true
            ;;
        --coverage|-c)
            RUN_COVERAGE=true
            ;;
        --changed)
            RUN_CHANGED=true
            ;;
        --update|-u)
            UPDATE_SNAPSHOTS=true
            ;;
        --verbose|-v)
            RUN_VERBOSE=true
            RUN_SILENT=false
            ;;
        --silent)
            RUN_SILENT=true
            ;;
        --no-bail)
            RUN_BAIL=false
            ;;
        --json)
            RUN_JSON=true
            ;;
        --bail|-b)
            RUN_BAIL=true
            ;;
        --testPathPattern=*)
            JEST_OPTS="$JEST_OPTS $arg"
            ;;
        --testNamePattern=*)
            JEST_OPTS="$JEST_OPTS $arg"
            ;;
        -*)
            # Pass through other flags to Jest
            EXTRA_ARGS="$EXTRA_ARGS $arg"
            ;;
        *)
            # Assume it's a test path
            TEST_PATH="$arg"
            ;;
    esac
done

# Build the Jest command
JEST_CMD="yarn test"

if [ "$RUN_WATCH" = true ]; then
    JEST_OPTS="$JEST_OPTS --watch"
fi

if [ "$RUN_COVERAGE" = true ]; then
    JEST_OPTS="$JEST_OPTS --coverage"
fi

if [ "$RUN_CHANGED" = true ]; then
    JEST_OPTS="$JEST_OPTS --onlyChanged"
fi

if [ "$UPDATE_SNAPSHOTS" = true ]; then
    JEST_OPTS="$JEST_OPTS --updateSnapshot"
fi

# Output mode options
if [ "$RUN_VERBOSE" = true ]; then
    JEST_OPTS="$JEST_OPTS --verbose --colors"
else
    # Default: minimal CI-style output
    JEST_OPTS="$JEST_OPTS --ci --colors=false"
fi

if [ "$RUN_SILENT" = true ]; then
    JEST_OPTS="$JEST_OPTS --silent"
fi

if [ "$RUN_JSON" = true ]; then
    JEST_OPTS="$JEST_OPTS --json"
fi

if [ "$RUN_BAIL" = true ]; then
    JEST_OPTS="$JEST_OPTS --bail"
fi

if [ -n "$TEST_PATH" ]; then
    JEST_OPTS="$JEST_OPTS $TEST_PATH"
fi

if [ -n "$EXTRA_ARGS" ]; then
    JEST_OPTS="$JEST_OPTS $EXTRA_ARGS"
fi

# Run the tests
# Only show header in verbose mode
if [ "$RUN_VERBOSE" = true ] && [ "$RUN_JSON" = false ]; then
    echo "Running tests from: $APP_DIR"
    echo "Command: $JEST_CMD $JEST_OPTS"
    echo "=========================================="
fi

$JEST_CMD $JEST_OPTS

# Exit code from Jest is preserved due to set -e
# 0 = all tests passed
# 1 = test failures
# Other = configuration/runtime errors
