#!/bin/bash

# =============================================================================
# Test Runner: Android / Gradle (AI Agent Optimized)
# =============================================================================
# Framework-specific runner for Android projects using Gradle.
# Invoked via .ai/scripts/run_tests.sh — do not call directly.
#
# Default behavior (no flags):
#   - Runs unit tests only (no device required)
#   - Primary variant: MerchantRedCloudDevDebug
#   - Stops on first failure (--continue is NOT set)
#   - Minimal output (--quiet)
#
# Usage (via .ai/scripts/run_tests.sh):
#   ./run_tests.sh                           # Run all unit tests (default variant)
#   ./run_tests.sh --module=:core            # Run unit tests for a specific module
#   ./run_tests.sh --class=LoginViewModelTest # Run a specific test class
#   ./run_tests.sh --verbose                 # Full Gradle output (for humans)
#   ./run_tests.sh --coverage               # Run with coverage report
#   ./run_tests.sh --continue               # Run all tests even if some fail
#   ./run_tests.sh --instrumented           # Run instrumented tests (requires device/emulator)
#   ./run_tests.sh --all                    # Run all unit test variants (TestAllUnitTests task)
#
# Examples:
#   ./run_tests.sh --module=:core
#   ./run_tests.sh --class=CheckoutViewModelTest
#   ./run_tests.sh --module=:app --class=LoginViewModelTest --verbose
#   ./run_tests.sh --instrumented --module=:app
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

# Verify gradlew exists at project root
GRADLEW="$PROJECT_ROOT/gradlew"
if [ ! -f "$GRADLEW" ]; then
    echo "Error: Could not find gradlew at $PROJECT_ROOT"
    echo "Please ensure you're running this script from the correct project."
    exit 1
fi

# Change to project root so Gradle resolves correctly
cd "$PROJECT_ROOT"

# =============================================================================
# Defaults — optimized for AI agents: minimal output, fail fast, no device
# =============================================================================
RUN_VERBOSE=false
RUN_COVERAGE=false
RUN_CONTINUE=false
RUN_INSTRUMENTED=false
RUN_ALL_VARIANTS=false
MODULE=""
TEST_CLASS=""
EXTRA_ARGS=""

# Default variant (unit tests)
DEFAULT_UNIT_TASK="testMerchantRedCloudDevDebugUnitTest"
DEFAULT_INSTRUMENTED_TASK="connectedMerchantRedCloudDevDebugAndroidTest"

# =============================================================================
# Parse arguments
# =============================================================================
for arg in "$@"; do
    case $arg in
        --verbose|-v)
            RUN_VERBOSE=true
            ;;
        --coverage|-c)
            RUN_COVERAGE=true
            ;;
        --continue)
            RUN_CONTINUE=true
            ;;
        --instrumented|-i)
            RUN_INSTRUMENTED=true
            ;;
        --all|-a)
            RUN_ALL_VARIANTS=true
            ;;
        --module=*)
            MODULE="${arg#--module=}"
            ;;
        --class=*)
            TEST_CLASS="${arg#--class=}"
            ;;
        -*)
            EXTRA_ARGS="$EXTRA_ARGS $arg"
            ;;
    esac
done

# =============================================================================
# Build Gradle command
# =============================================================================
GRADLE_OPTS=""

# Quiet by default; verbose overrides
if [ "$RUN_VERBOSE" = false ]; then
    GRADLE_OPTS="$GRADLE_OPTS --quiet"
fi

# Stop on first failure unless --continue is set
if [ "$RUN_CONTINUE" = true ]; then
    GRADLE_OPTS="$GRADLE_OPTS --continue"
fi

# Pass extra args through
if [ -n "$EXTRA_ARGS" ]; then
    GRADLE_OPTS="$GRADLE_OPTS $EXTRA_ARGS"
fi

# Test filter for a specific class
TEST_FILTER=""
if [ -n "$TEST_CLASS" ]; then
    TEST_FILTER="--tests \"*.$TEST_CLASS\""
fi

# =============================================================================
# Determine Gradle task
# =============================================================================
if [ "$RUN_ALL_VARIANTS" = true ] && [ -z "$MODULE" ] && [ "$RUN_INSTRUMENTED" = false ]; then
    # Custom task that covers all unit test variants
    GRADLE_TASK="TestAllUnitTests"
elif [ -n "$MODULE" ]; then
    if [ "$RUN_INSTRUMENTED" = true ]; then
        # Module-level instrumented tests (requires device)
        GRADLE_TASK="${MODULE}:connectedMerchantRedCloudDevDebugAndroidTest"
    else
        # Module-level unit tests
        GRADLE_TASK="${MODULE}:testMerchantRedCloudDevDebugUnitTest"
        # Fallback for non-app modules (core, registration, etc.) which use plain :test
        if ! ./gradlew "$MODULE:tasks" --quiet 2>/dev/null | grep -q "testMerchantRedCloudDevDebugUnitTest"; then
            GRADLE_TASK="${MODULE}:test"
        fi
    fi
elif [ "$RUN_INSTRUMENTED" = true ]; then
    GRADLE_TASK="$DEFAULT_INSTRUMENTED_TASK"
else
    GRADLE_TASK="$DEFAULT_UNIT_TASK"
fi

# Append coverage task if requested
if [ "$RUN_COVERAGE" = true ]; then
    GRADLE_TASK="$GRADLE_TASK testReport"
fi

# =============================================================================
# Run
# =============================================================================
if [ "$RUN_VERBOSE" = true ]; then
    echo "Project root : $PROJECT_ROOT"
    echo "Task         : $GRADLE_TASK"
    echo "Options      : $GRADLE_OPTS $TEST_FILTER"
    echo "=========================================="
fi

# shellcheck disable=SC2086
eval "$GRADLEW $GRADLE_TASK $GRADLE_OPTS $TEST_FILTER"

# Exit code from Gradle is preserved due to set -e
# 0 = all tests passed
# 1 = test failures or build error
