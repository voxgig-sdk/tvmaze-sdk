# Tvmaze SDK

Free REST API for TV shows, episodes, cast, crew and schedules, with JSON responses and HAL-style links

> TypeScript, Python, PHP, Golang, Ruby, Lua SDKs, a CLI, an interactive REPL, and an MCP server for AI agents — all generated from one OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).

## About TVmaze API

[TVmaze](https://www.tvmaze.com/) runs a free, public REST API for television metadata. Responses are JSON and follow HATEOAS / HAL conventions, so related resources are reachable via embedded links.

What you get from the API:

- Shows: details, seasons, episodes, cast, crew, AKAs, images, and alternate episode lists.
- People: cast and crew profiles with cast credits, crew credits and guest-cast credits.
- Schedules: per-country daily TV schedule, web/streaming schedule, and a full schedule dump.
- Search and lookup: search shows or people by name, single-result search, or lookup by TVRage / TheTVDB / IMDb ID.
- Updates: timestamps for changed shows or people, optionally filtered to the last day, week or month.

The public endpoints require no API key and have CORS enabled, so they can be called directly from a browser. The API is rate limited to at least 20 calls per 10 seconds per IP address; exceeding the limit returns HTTP 429. Responses are cached by the load balancer for around 60 minutes; the separate user-level API requires a Premium TVmaze account.

## Try it

**TypeScript**
```bash
npm install tvmaze
```

**Python**
```bash
pip install tvmaze-sdk
```

**PHP**
```bash
composer require voxgig/tvmaze-sdk
```

**Golang**
```bash
go get github.com/voxgig-sdk/tvmaze-sdk/go
```

**Ruby**
```bash
gem install tvmaze-sdk
```

**Lua**
```bash
luarocks install tvmaze-sdk
```

## 30-second quickstart

### TypeScript

```ts
import { TvmazeSDK } from 'tvmaze'

const client = new TvmazeSDK({})

// List all akas
const akas = await client.Aka().list()
```

See the [TypeScript README](ts/README.md) for the
full guide, or scroll down for the same example in other languages.

## What's in the box

| Surface | Use it for | Path |
| --- | --- | --- |
| **SDK** (TypeScript, Python, PHP, Golang, Ruby, Lua) | App integration | `ts/` `py/` `php/` `go/` `rb/` `lua/` |
| **CLI** | Scripts, CI, ops, one-off API calls | `go-cli/` |
| **MCP server** | AI agents (Claude, Cursor, Cline) | `go-mcp/` |

## Use it from an AI agent (MCP)

The generated MCP server exposes every operation in this SDK as an
[MCP](https://modelcontextprotocol.io) tool that Claude, Cursor or Cline
can call directly. Build and register it:

```bash
cd go-mcp && go build -o tvmaze-mcp .
```

Then add it to your agent's MCP config (Claude Desktop, Cursor, etc.):

```json
{
  "mcpServers": {
    "tvmaze": {
      "command": "/abs/path/to/tvmaze-mcp"
    }
  }
}
```

## Entities

The API exposes 18 entities:

| Entity | Description | API path |
| --- | --- | --- |
| **Aka** | Alternative titles a show is known by in other regions, served from `/shows/:id/akas`. | `/shows/{id}/akas` |
| **AlternateList** | A named alternate ordering of a show's episodes, available at `/shows/:id/alternatelists` and `/alternatelists/:id`. | `/shows/{id}/alternatelists` |
| **Cast** | The cast of a show — a list of person/character pairs returned from `/shows/:id/cast`. | `/shows/{id}/cast` |
| **CastCredit** | A single acting credit for a person on a show, served from `/people/:id/castcredits`. | `/people/{id}/castcredits` |
| **CastMember** | An individual entry in a show's cast pairing a person with the character they play. | `/episodes/{id}/guestcast` |
| **Crew** | The crew of a show — production roles paired with people, returned from `/shows/:id/crew`. | `/shows/{id}/crew` |
| **CrewCredit** | A single crew credit for a person on a show, served from `/people/:id/crewcredits`. | `/people/{id}/crewcredits` |
| **CrewMember** | An individual entry in a show's crew pairing a person with their production role. | `/episodes/{id}/guestcrew` |
| **Episode** | A single episode of a show, addressable at `/episodes/:id` and listed under `/shows/:id/episodes` and `/seasons/:id/episodes`. | `/shows/{id}/episodesbydate` |
| **GuestCastCredit** | A guest-starring acting credit for a person, served from `/people/:id/guestcastcredits` and `/episodes/:id/guestcast`. | `/people/{id}/guestcastcredits` |
| **Image** | Artwork associated with a show (posters, banners, backgrounds), returned from `/shows/:id/images`. | `/shows/{id}/images` |
| **Person** | A cast or crew member profile, available at `/people/:id`, with paginated listing at `/people?page=:num` and search via `/search/people?q=:query`. | `/people` |
| **Schedule** | The TV schedule for a given country and date, served from `/schedule`, `/schedule/web`, and `/schedule/full`. | `/schedule` |
| **ScheduledEpisode** | An entry in a schedule response — an episode airing at a specific time on a specific network. | `/schedule/web` |
| **Search** | Free-text search across shows or people, via `/search/shows`, `/singlesearch/shows`, `/lookup/shows`, and `/search/people`. | `/lookup/shows` |
| **Season** | A season of a show, with episodes listed at `/seasons/:id/episodes` and per-show seasons at `/shows/:id/seasons`. | `/shows/{id}/seasons` |
| **Show** | A television show, addressable at `/shows/:id`, with paginated listing at `/shows?page=:num`. | `/alternatelists/{id}/alternateepisodes` |
| **Update** | A map of show or person IDs to last-updated timestamps, served from `/updates/shows` and `/updates/people` with an optional `?since=day|week|month` filter. | `/updates/people` |

Each entity supports the following operations where available: **load**,
**list**, **create**, **update**, and **remove**.

## Quickstart in other languages

### Python

```python
from tvmaze_sdk import TvmazeSDK

client = TvmazeSDK({})

# List all akas
akas, err = client.Aka(None).list(None, None)
```

### PHP

```php
<?php
require_once 'tvmaze_sdk.php';

$client = new TvmazeSDK([]);

// List all akas
[$akas, $err] = $client->Aka(null)->list(null, null);
```

### Golang

```go
import sdk "github.com/voxgig-sdk/tvmaze-sdk/go"

client := sdk.NewTvmazeSDK(map[string]any{})

// List all akas
akas, err := client.Aka(nil).List(nil, nil)
```

### Ruby

```ruby
require_relative "Tvmaze_sdk"

client = TvmazeSDK.new({})

# List all akas
akas, err = client.Aka(nil).list(nil, nil)
```

### Lua

```lua
local sdk = require("tvmaze_sdk")

local client = sdk.new({})

-- List all akas
local akas, err = client:Aka(nil):list(nil, nil)
```

## Unit testing in offline mode

Every SDK ships a test mode that swaps the HTTP transport for an
in-memory mock, so unit tests run offline.

### TypeScript

```ts
const client = TvmazeSDK.test()
const result = await client.Aka().load({ id: 'test01' })
// result.ok === true, result.data contains mock data
```

### Python

```python
client = TvmazeSDK.test(None, None)
result, err = client.Aka(None).load(
    {"id": "test01"}, None
)
```

### PHP

```php
$client = TvmazeSDK::test(null, null);
[$result, $err] = $client->Aka(null)->load(
    ["id" => "test01"], null
);
```

### Golang

```go
client := sdk.TestSDK(nil, nil)
result, err := client.Aka(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
```

### Ruby

```ruby
client = TvmazeSDK.test(nil, nil)
result, err = client.Aka(nil).load(
  { "id" => "test01" }, nil
)
```

### Lua

```lua
local client = sdk.test(nil, nil)
local result, err = client:Aka(nil):load(
  { id = "test01" }, nil
)
```

## How it works

Every SDK call runs the same five-stage pipeline:

1. **Point** — resolve the API endpoint from the operation definition.
2. **Spec** — build the HTTP specification (URL, method, headers, body).
3. **Request** — send the HTTP request.
4. **Response** — receive and parse the response.
5. **Result** — extract the result data for the caller.

A feature hook fires at each stage (e.g. `PrePoint`, `PreSpec`,
`PreRequest`), so features can inspect or modify the pipeline without
forking the SDK.

### Features

| Feature | Purpose |
| --- | --- |
| **TestFeature** | In-memory mock transport for testing without a live server |

Pass custom features via the `extend` option at construction time.

### Direct and Prepare

For endpoints the entity model doesn't cover, use the low-level methods:

- **`direct(fetchargs)`** — build and send an HTTP request in one step.
- **`prepare(fetchargs)`** — build the request without sending it.

Both accept a map with `path`, `method`, `params`, `query`,
`headers`, and `body`. See the [How-to guides](#how-to-guides) below.

## How-to guides

### Make a direct API call

When the entity interface does not cover an endpoint, use `direct`:

**TypeScript:**
```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})
console.log(result.data)
```

**Python:**
```python
result, err = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
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

**Go:**
```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
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

**Lua:**
```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
```

## Per-language documentation

- [TypeScript](ts/README.md)
- [Python](py/README.md)
- [PHP](php/README.md)
- [Golang](go/README.md)
- [Ruby](rb/README.md)
- [Lua](lua/README.md)

## Using the TVmaze API

- Upstream: [https://www.tvmaze.com/api](https://www.tvmaze.com/api)

- Data is licensed under Creative Commons Attribution-ShareAlike (CC BY-SA).
- Attribution to [TVmaze](https://www.tvmaze.com/) is required.
- Derivative works must be shared under the same ShareAlike terms.
- See the [TVmaze API page](https://www.tvmaze.com/api) for the authoritative licensing statement.

---

Generated from the TVmaze API OpenAPI spec by [@voxgig/sdkgen](https://github.com/voxgig/sdkgen).
