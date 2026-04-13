# Test Conventions: Android (JUnit4 + Kotlin)

Extends `.ai/shared/TEST_CONVENTIONS.md`. Follow both.

## Shared Network Test Utilities

The `registration` module has shared helpers for common network failure scenarios. Use these rather than writing raw `MockResponse` boilerplate:

```kotlin
import com.redcloudtechnology.registration.utils.TestUtils.noConnection
import com.redcloudtechnology.registration.utils.TestUtils.response500
import com.redcloudtechnology.registration.utils.TestUtils.responseUnknownError
import com.redcloudtechnology.registration.utils.TestAuthenticator
```

`TestAuthenticator.setupMockServer(server)` wires the `MockWebServer` base URL into Retrofit — call it in `@Before` for any repository test that needs authenticated API calls.
