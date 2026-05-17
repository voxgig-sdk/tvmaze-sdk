# Tvmaze SDK



Available for [Golang](go/) and [Go CLI](go-cli/) and [Lua](lua/) and [PHP](php/) and [Python](py/) and [Ruby](rb/) and [TypeScript](ts/).


## Entities

The API exposes 18 entities:

| Entity | Description | API path |
| --- | --- | --- |
| **Aka** |  | `/shows/{id}/akas` |
| **AlternateList** |  | `/shows/{id}/alternatelists` |
| **Cast** |  | `/shows/{id}/cast` |
| **CastCredit** |  | `/people/{id}/castcredits` |
| **CastMember** |  | `/episodes/{id}/guestcast` |
| **Crew** |  | `/shows/{id}/crew` |
| **CrewCredit** |  | `/people/{id}/crewcredits` |
| **CrewMember** |  | `/episodes/{id}/guestcrew` |
| **Episode** |  | `/shows/{id}/episodesbydate` |
| **GuestCastCredit** |  | `/people/{id}/guestcastcredits` |
| **Image** |  | `/shows/{id}/images` |
| **Person** |  | `/people` |
| **Schedule** |  | `/schedule` |
| **ScheduledEpisode** |  | `/schedule/web` |
| **Search** |  | `/lookup/shows` |
| **Season** |  | `/shows/{id}/seasons` |
| **Show** |  | `/alternatelists/{id}/alternateepisodes` |
| **Update** |  | `/updates/people` |

Each entity supports the following operations where available: **load**, **list**, **create**,
**update**, and **remove**.


## Architecture

### Entity-operation model

Every SDK call follows the same pipeline:

1. **Point** — resolve the API endpoint from the operation definition.
2. **Spec** — build the HTTP specification (URL, method, headers, body).
3. **Request** — send the HTTP request.
4. **Response** — receive and parse the response.
5. **Result** — extract the result data for the caller.

At each stage a feature hook fires (e.g. `PrePoint`, `PreSpec`,
`PreRequest`), allowing features to inspect or modify the pipeline.

### Features

Features are hook-based middleware that extend SDK behaviour.

| Feature | Purpose |
| --- | --- |
| **TestFeature** | In-memory mock transport for testing without a live server |

You can add custom features by passing them in the `extend` option at
construction time.

### Direct and Prepare

For endpoints not covered by the entity model, use the low-level methods:

- **`direct(fetchargs)`** — build and send an HTTP request in one step.
- **`prepare(fetchargs)`** — build the request without sending it.

Both accept a map with `path`, `method`, `params`, `query`, `headers`,
and `body`.


## Quick start

### Golang

```go
import sdk "github.com/voxgig-sdk/tvmaze-sdk/go"

client := sdk.NewTvmazeSDK(map[string]any{
    "apikey": os.Getenv("TVMAZE_APIKEY"),
})

// List all akas
akas, err := client.Aka(nil).List(nil, nil)
```

### Lua

```lua
local sdk = require("tvmaze_sdk")

local client = sdk.new({
  apikey = os.getenv("TVMAZE_APIKEY"),
})

-- List all akas
local akas, err = client:Aka(nil):list(nil, nil)
```

### PHP

```php
<?php
require_once 'tvmaze_sdk.php';

$client = new TvmazeSDK([
    "apikey" => getenv("TVMAZE_APIKEY"),
]);

// List all akas
[$akas, $err] = $client->Aka(null)->list(null, null);
```

### Python

```python
import os
from tvmaze_sdk import TvmazeSDK

client = TvmazeSDK({
    "apikey": os.environ.get("TVMAZE_APIKEY"),
})

# List all akas
akas, err = client.Aka(None).list(None, None)
```

### Ruby

```ruby
require_relative "Tvmaze_sdk"

client = TvmazeSDK.new({
  "apikey" => ENV["TVMAZE_APIKEY"],
})

# List all akas
akas, err = client.Aka(nil).list(nil, nil)
```

### TypeScript

```ts
import { TvmazeSDK } from 'tvmaze'

const client = new TvmazeSDK({
  apikey: process.env.TVMAZE_APIKEY,
})

// List all akas
const akas = await client.Aka().list()
```


## Testing

Both SDKs provide a test mode that replaces the HTTP transport with an
in-memory mock, so tests run without a network connection.

### Golang

```go
client := sdk.TestSDK(nil, nil)
result, err := client.Aka(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
```

### Lua

```lua
local client = sdk.test(nil, nil)
local result, err = client:Aka(nil):load(
  { id = "test01" }, nil
)
```

### PHP

```php
$client = TvmazeSDK::test(null, null);
[$result, $err] = $client->Aka(null)->load(
    ["id" => "test01"], null
);
```

### Python

```python
client = TvmazeSDK.test(None, None)
result, err = client.Aka(None).load(
    {"id": "test01"}, None
)
```

### Ruby

```ruby
client = TvmazeSDK.test(nil, nil)
result, err = client.Aka(nil).load(
  { "id" => "test01" }, nil
)
```

### TypeScript

```ts
const client = TvmazeSDK.test()
const result = await client.Aka().load({ id: 'test01' })
// result.ok === true, result.data contains mock data
```


## How-to guides

### Make a direct API call

When the entity interface does not cover an endpoint, use `direct`:

**Go:**
```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
```

**Lua:**
```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
```

**PHP:**
```php
[$result, $err] = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);
```

**Python:**
```python
result, err = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})
```

**Ruby:**
```ruby
result, err = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})
```

**TypeScript:**
```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})
console.log(result.data)
```


## Language-specific documentation

- [Golang SDK](go/README.md)
- [Go CLI SDK](go-cli/README.md)
- [Lua SDK](lua/README.md)
- [PHP SDK](php/README.md)
- [Python SDK](py/README.md)
- [Ruby SDK](rb/README.md)
- [TypeScript SDK](ts/README.md)

