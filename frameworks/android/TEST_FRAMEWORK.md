# Test Framework: JUnit4 + Mockito + Robolectric (Android)

## Pending Test Marker

Use `@Ignore("Test disabled to be fixed later")` to skip tests. The suite does not fail on ignored tests — they show up as **skipped** in the Gradle output (e.g. `363 tests completed, 1 failed, 14 skipped`). A passing suite with skipped tests does not mean those tests are resolved.

Before committing test files, check for ignored tests:
```bash
grep -r "@Ignore" <test files being committed>
```

## Non-App Modules Use a Different Task

`testMerchantRedCloudDevDebugUnitTest` only exists on `:app`. Modules like `:core`, `:registration`, and `:topup` use `:test` instead:
```bash
./gradlew :core:test
./gradlew :registration:test
```
Running the variant task against these modules will fail with "task not found".

## ObjectBox Log Noise is Normal

Unit test runs emit a wall of `[INFO]` ObjectBox query logs to stdout. This is expected — it is not a failure indicator. Output like this is normal:
```
001-14:40:55.7756 [INFO ] Creating query #1 for NotificationMessageEntity with 1 condition(s)
```

## `unitTests.isReturnDefaultValues = true`

This is set globally in `app/build.gradle.kts`. It means Android framework methods called in unit tests return default values (0, null, false) instead of throwing `RuntimeException: Stub!`. You do not need to mock every Android API — only the ones whose return value your code actually branches on.
