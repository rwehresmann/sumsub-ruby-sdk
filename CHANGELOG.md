### 0.1.2
  - An instance of `Sumsub::Request` returns now only the url without `/resources` (e.g., `sumsub.url` was `https://api.sumsub.com/resources` and now it is `https://api.sumsub.com`).

### 0.1.3
  - Require level name as argument in `get_access_token` of `Sumsub::Request`. This change makes the method compatible with the [recent updates in the Sumsub SDK](https://developers.sumsub.com/migrations/sdk.html#sdk-migration-guide).

### 0.1.4
  - General minor fixes (don't require dev gems in the production build, add extra ignored files in `.gitignore`, etc);
  - Move the `require 'dry-struct'` to the `lib/sumsub.rb`, so we don't need to always require it in our structs;
  - Add [`generate_external_link`](https://developers.sumsub.com/api-reference/additional-methods.html#generating-websdk-external-link-for-particular-user);
  - Updated structs with new fields;
  - Add `WebhookSender` with `get_payload` class method to format the payload before informing it to the `verify_webhook_sender` method (those strange string transformations are necessary in order to receive the right answer from Sumsub).

### 0.2.1
  - New rejection labels ([PR](ydakuka:replace-old-reject-label-with-new-ones))
