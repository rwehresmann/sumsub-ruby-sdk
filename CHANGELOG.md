### 0.1.2
  - An instance of `Sumsub::Request` returns now only the url without `/resources` (e.g., `sumsub.url` was `https://api.sumsub.com/resources` and now it is `https://api.sumsub.com`).

### 0.1.3
  - Require level name as argument in `get_access_token` of `Sumsub::Request`. This change makes the method compatible with the [recent updates in the Sumsub SDK](https://developers.sumsub.com/migrations/sdk.html#sdk-migration-guide).
