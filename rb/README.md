# Tvmaze Ruby SDK



The Ruby SDK for the Tvmaze API — an entity-oriented client using idiomatic Ruby conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Aka` — with named operations (`list`/`load`) instead of raw URL paths and query strings. Working with resources and verbs keeps call sites self-describing and reduces cognitive load.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to RubyGems. Install it from the
GitHub release tag (`rb/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/tvmaze-sdk/releases](https://github.com/voxgig-sdk/tvmaze-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ruby
require_relative "Tvmaze_sdk"

client = TvmazeSDK.new
```

### 2. List aka records

```ruby
begin
  # list returns an Array of Aka records — iterate directly.
  akas = client.Aka.list
  akas.each do |item|
    puts "#{item["country"]}"
  end
rescue => err
  warn "list failed: #{err}"
end
```


## Error handling

Entity operations raise on failure, so rescue them:

```ruby
begin
  akas = client.Aka.list()
rescue => err
  warn "list failed: #{err}"
end
```

`direct` does **not** raise — it returns the result hash. Branch on
`ok`; on failure `status` holds the HTTP status (for error responses) and
`err` holds a transport error, so read both defensively:

```ruby
result = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example_id" },
})

warn "request failed: #{result["err"] || "HTTP #{result["status"]}"}" unless result["ok"]
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```ruby
result = client.direct({
  "path" => "/api/resource/{id}",
  "method" => "GET",
  "params" => { "id" => "example" },
})

if result["ok"]
  puts result["status"]  # 200
  puts result["data"]    # response body
else
  # On an HTTP error status there is no err (only a transport failure sets
  # it), so fall back to the status code.
  warn(result["err"] || "HTTP #{result["status"]}")
end
```

### Prepare a request without sending it

```ruby
begin
  fetchdef = client.prepare({
    "path" => "/api/resource/{id}",
    "method" => "DELETE",
    "params" => { "id" => "example" },
  })
  puts fetchdef["url"]
  puts fetchdef["method"]
  puts fetchdef["headers"]
rescue => err
  warn "prepare failed: #{err}"
end
```

### Use test mode

Create a mock client for unit testing — no server required:

```ruby
client = TvmazeSDK.test

# Entity ops return the bare mock record (raises on error).
aka = client.Aka.list()
puts aka
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```ruby
mock_fetch = ->(url, init) {
  return {
    "status" => 200,
    "statusText" => "OK",
    "headers" => {},
    "json" => ->() { { "id" => "mock01" } },
  }, nil
}

client = TvmazeSDK.new({
  "base" => "http://localhost:8080",
  "system" => {
    "fetch" => mock_fetch,
  },
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
TVMAZE_TEST_LIVE=TRUE
```

Then run:

```bash
cd rb && ruby -Itest -e "Dir['test/*_test.rb'].each { |f| require_relative f }"
```


## Reference

### TvmazeSDK

```ruby
require_relative "Tvmaze_sdk"
client = TvmazeSDK.new(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `base` | `String` | Base URL of the API server. |
| `prefix` | `String` | URL path prefix prepended to all requests. |
| `suffix` | `String` | URL path suffix appended to all requests. |
| `feature` | `Hash` | Feature activation flags. |
| `extend` | `Hash` | Additional Feature instances to load. |
| `system` | `Hash` | System overrides (e.g. custom `fetch` lambda). |

### test

```ruby
client = TvmazeSDK.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### TvmazeSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> Hash` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> Hash` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> Hash` | Build and send an HTTP request. Returns a result hash (`result["ok"]`); does not raise. |
| `Aka` | `(data) -> AkaEntity` | Create an Aka entity instance. |
| `AlternateList` | `(data) -> AlternateListEntity` | Create an AlternateList entity instance. |
| `Cast` | `(data) -> CastEntity` | Create a Cast entity instance. |
| `CastCredit` | `(data) -> CastCreditEntity` | Create a CastCredit entity instance. |
| `CastMember` | `(data) -> CastMemberEntity` | Create a CastMember entity instance. |
| `Crew` | `(data) -> CrewEntity` | Create a Crew entity instance. |
| `CrewCredit` | `(data) -> CrewCreditEntity` | Create a CrewCredit entity instance. |
| `CrewMember` | `(data) -> CrewMemberEntity` | Create a CrewMember entity instance. |
| `Episode` | `(data) -> EpisodeEntity` | Create an Episode entity instance. |
| `GuestCastCredit` | `(data) -> GuestCastCreditEntity` | Create a GuestCastCredit entity instance. |
| `Image` | `(data) -> ImageEntity` | Create an Image entity instance. |
| `Person` | `(data) -> PersonEntity` | Create a Person entity instance. |
| `Schedule` | `(data) -> ScheduleEntity` | Create a Schedule entity instance. |
| `ScheduledEpisode` | `(data) -> ScheduledEpisodeEntity` | Create a ScheduledEpisode entity instance. |
| `Search` | `(data) -> SearchEntity` | Create a Search entity instance. |
| `Season` | `(data) -> SeasonEntity` | Create a Season entity instance. |
| `Show` | `(data) -> ShowEntity` | Create a Show entity instance. |
| `Update` | `(data) -> UpdateEntity` | Create an Update entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> any` | Load a single entity by match criteria. Raises on error. |
| `list` | `(reqmatch = nil, ctrl) -> Array` | List entities matching the criteria (call with no argument to list all). Raises on error. |
| `data_get` | `() -> Hash` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> Hash` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> String` | Return the entity name. |

### Result shape

Entity operations return the result data directly. On failure they
raise a `TvmazeError` (a `StandardError` subclass), so wrap
calls in `begin`/`rescue` where you need to handle errors.

The `direct` escape hatch is the exception: it never raises and instead
returns a result `Hash` with these keys:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `Boolean` | `true` if the HTTP status is 2xx. |
| `status` | `Integer` | HTTP status code. |
| `headers` | `Hash` | Response headers. |
| `data` | `any` | Parsed JSON response body. |
| `err` | `Error` | Present when `ok` is `false`. |

### Entities

#### Aka

| Field | Description |
| --- | --- |
| `country` |  |
| `name` |  |

Operations: List.

API path: `/shows/{id}/akas`

#### AlternateList

| Field | Description |
| --- | --- |
| `id` |  |
| `link` |  |
| `name` |  |
| `url` |  |

Operations: List, Load.

API path: `/shows/{id}/alternatelists`

#### Cast

| Field | Description |
| --- | --- |
| `character` |  |
| `person` |  |
| `self` |  |
| `voice` |  |

Operations: List.

API path: `/shows/{id}/cast`

#### CastCredit

| Field | Description |
| --- | --- |
| `link` |  |

Operations: List.

API path: `/people/{id}/castcredits`

#### CastMember

| Field | Description |
| --- | --- |
| `character` |  |
| `person` |  |
| `self` |  |
| `voice` |  |

Operations: List.

API path: `/episodes/{id}/guestcast`

#### Crew

| Field | Description |
| --- | --- |
| `person` |  |
| `type` |  |

Operations: List.

API path: `/shows/{id}/crew`

#### CrewCredit

| Field | Description |
| --- | --- |
| `link` |  |
| `type` |  |

Operations: List.

API path: `/people/{id}/crewcredits`

#### CrewMember

| Field | Description |
| --- | --- |
| `person` |  |
| `type` |  |

Operations: List.

API path: `/episodes/{id}/guestcrew`

#### Episode

| Field | Description |
| --- | --- |
| `airdate` |  |
| `airstamp` |  |
| `airtime` |  |
| `id` |  |
| `image` |  |
| `link` |  |
| `name` |  |
| `number` |  |
| `rating` |  |
| `runtime` |  |
| `season` |  |
| `summary` |  |
| `type` |  |
| `url` |  |

Operations: List, Load.

API path: `/shows/{id}/episodesbydate`

#### GuestCastCredit

| Field | Description |
| --- | --- |
| `link` |  |

Operations: List.

API path: `/people/{id}/guestcastcredits`

#### Image

| Field | Description |
| --- | --- |
| `id` |  |
| `main` |  |
| `resolution` |  |
| `type` |  |

Operations: List.

API path: `/shows/{id}/images`

#### Person

| Field | Description |
| --- | --- |
| `birthday` |  |
| `country` |  |
| `deathday` |  |
| `gender` |  |
| `id` |  |
| `image` |  |
| `link` |  |
| `name` |  |
| `person` |  |
| `score` |  |
| `updated` |  |
| `url` |  |

Operations: List, Load.

API path: `/people`

#### Schedule

| Field | Description |
| --- | --- |
| `airdate` |  |
| `airstamp` |  |
| `airtime` |  |
| `id` |  |
| `image` |  |
| `link` |  |
| `name` |  |
| `number` |  |
| `rating` |  |
| `runtime` |  |
| `season` |  |
| `show` |  |
| `summary` |  |
| `type` |  |
| `url` |  |

Operations: List.

API path: `/schedule`

#### ScheduledEpisode

| Field | Description |
| --- | --- |
| `airdate` |  |
| `airstamp` |  |
| `airtime` |  |
| `id` |  |
| `image` |  |
| `link` |  |
| `name` |  |
| `number` |  |
| `rating` |  |
| `runtime` |  |
| `season` |  |
| `show` |  |
| `summary` |  |
| `type` |  |
| `url` |  |

Operations: List.

API path: `/schedule/web`

#### Search

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/lookup/shows`

#### Season

| Field | Description |
| --- | --- |
| `end_date` |  |
| `episode_order` |  |
| `id` |  |
| `image` |  |
| `link` |  |
| `name` |  |
| `network` |  |
| `number` |  |
| `premiere_date` |  |
| `summary` |  |
| `url` |  |
| `web_channel` |  |

Operations: List.

API path: `/shows/{id}/seasons`

#### Show

| Field | Description |
| --- | --- |
| `average_runtime` |  |
| `dvd_country` |  |
| `ended` |  |
| `external` |  |
| `genre` |  |
| `id` |  |
| `image` |  |
| `language` |  |
| `link` |  |
| `name` |  |
| `network` |  |
| `official_site` |  |
| `premiered` |  |
| `rating` |  |
| `runtime` |  |
| `schedule` |  |
| `score` |  |
| `show` |  |
| `status` |  |
| `summary` |  |
| `type` |  |
| `updated` |  |
| `url` |  |
| `web_channel` |  |
| `weight` |  |

Operations: List, Load.

API path: `/alternatelists/{id}/alternateepisodes`

#### Update

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/updates/people`



## Entities


### Aka

Create an instance: `aka = client.Aka`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country` | `Hash` |  |
| `name` | `String` |  |

#### Example: List

```ruby
# list returns an Array of Aka records (raises on error).
akas = client.Aka.list
```


### AlternateList

Create an instance: `alternate_list = client.AlternateList`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `Integer` |  |
| `link` | `Hash` |  |
| `name` | `String` |  |
| `url` | `String` |  |

#### Example: Load

```ruby
# load returns the bare AlternateList record (raises on error).
alternate_list = client.AlternateList.load({ "id" => "alternate_list_id" })
```

#### Example: List

```ruby
# list returns an Array of AlternateList records (raises on error).
alternate_lists = client.AlternateList.list
```


### Cast

Create an instance: `cast = client.Cast`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `character` | `Hash` |  |
| `person` | `Hash` |  |
| `self` | `Boolean` |  |
| `voice` | `Boolean` |  |

#### Example: List

```ruby
# list returns an Array of Cast records (raises on error).
casts = client.Cast.list
```


### CastCredit

Create an instance: `cast_credit = client.CastCredit`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `link` | `Hash` |  |

#### Example: List

```ruby
# list returns an Array of CastCredit records (raises on error).
cast_credits = client.CastCredit.list
```


### CastMember

Create an instance: `cast_member = client.CastMember`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `character` | `Hash` |  |
| `person` | `Hash` |  |
| `self` | `Boolean` |  |
| `voice` | `Boolean` |  |

#### Example: List

```ruby
# list returns an Array of CastMember records (raises on error).
cast_members = client.CastMember.list
```


### Crew

Create an instance: `crew = client.Crew`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `person` | `Hash` |  |
| `type` | `String` |  |

#### Example: List

```ruby
# list returns an Array of Crew records (raises on error).
crews = client.Crew.list
```


### CrewCredit

Create an instance: `crew_credit = client.CrewCredit`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `link` | `Hash` |  |
| `type` | `String` |  |

#### Example: List

```ruby
# list returns an Array of CrewCredit records (raises on error).
crew_credits = client.CrewCredit.list
```


### CrewMember

Create an instance: `crew_member = client.CrewMember`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `person` | `Hash` |  |
| `type` | `String` |  |

#### Example: List

```ruby
# list returns an Array of CrewMember records (raises on error).
crew_members = client.CrewMember.list
```


### Episode

Create an instance: `episode = client.Episode`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `airdate` | `String` |  |
| `airstamp` | `String` |  |
| `airtime` | `String` |  |
| `id` | `Integer` |  |
| `image` | `Hash` |  |
| `link` | `Hash` |  |
| `name` | `String` |  |
| `number` | `Integer` |  |
| `rating` | `Hash` |  |
| `runtime` | `Integer` |  |
| `season` | `Integer` |  |
| `summary` | `String` |  |
| `type` | `String` |  |
| `url` | `String` |  |

#### Example: Load

```ruby
# load returns the bare Episode record (raises on error).
episode = client.Episode.load({ "id" => "episode_id" })
```

#### Example: List

```ruby
# list returns an Array of Episode records (raises on error).
episodes = client.Episode.list
```


### GuestCastCredit

Create an instance: `guest_cast_credit = client.GuestCastCredit`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `link` | `Hash` |  |

#### Example: List

```ruby
# list returns an Array of GuestCastCredit records (raises on error).
guest_cast_credits = client.GuestCastCredit.list
```


### Image

Create an instance: `image = client.Image`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `Integer` |  |
| `main` | `Boolean` |  |
| `resolution` | `Hash` |  |
| `type` | `String` |  |

#### Example: List

```ruby
# list returns an Array of Image records (raises on error).
images = client.Image.list
```


### Person

Create an instance: `person = client.Person`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday` | `String` |  |
| `country` | `Hash` |  |
| `deathday` | `String` |  |
| `gender` | `String` |  |
| `id` | `Integer` |  |
| `image` | `Hash` |  |
| `link` | `Hash` |  |
| `name` | `String` |  |
| `person` | `Hash` |  |
| `score` | `Float` |  |
| `updated` | `Integer` |  |
| `url` | `String` |  |

#### Example: Load

```ruby
# load returns the bare Person record (raises on error).
person = client.Person.load({ "id" => "person_id" })
```

#### Example: List

```ruby
# list returns an Array of Person records (raises on error).
persons = client.Person.list
```


### Schedule

Create an instance: `schedule = client.Schedule`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `airdate` | `String` |  |
| `airstamp` | `String` |  |
| `airtime` | `String` |  |
| `id` | `Integer` |  |
| `image` | `Hash` |  |
| `link` | `Hash` |  |
| `name` | `String` |  |
| `number` | `Integer` |  |
| `rating` | `Hash` |  |
| `runtime` | `Integer` |  |
| `season` | `Integer` |  |
| `show` | `Hash` |  |
| `summary` | `String` |  |
| `type` | `String` |  |
| `url` | `String` |  |

#### Example: List

```ruby
# list returns an Array of Schedule records (raises on error).
schedules = client.Schedule.list
```


### ScheduledEpisode

Create an instance: `scheduled_episode = client.ScheduledEpisode`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `airdate` | `String` |  |
| `airstamp` | `String` |  |
| `airtime` | `String` |  |
| `id` | `Integer` |  |
| `image` | `Hash` |  |
| `link` | `Hash` |  |
| `name` | `String` |  |
| `number` | `Integer` |  |
| `rating` | `Hash` |  |
| `runtime` | `Integer` |  |
| `season` | `Integer` |  |
| `show` | `Hash` |  |
| `summary` | `String` |  |
| `type` | `String` |  |
| `url` | `String` |  |

#### Example: List

```ruby
# list returns an Array of ScheduledEpisode records (raises on error).
scheduled_episodes = client.ScheduledEpisode.list
```


### Search

Create an instance: `search = client.Search`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ruby
# load returns the bare Search record (raises on error).
search = client.Search.load()
```


### Season

Create an instance: `season = client.Season`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `end_date` | `String` |  |
| `episode_order` | `Integer` |  |
| `id` | `Integer` |  |
| `image` | `Hash` |  |
| `link` | `Hash` |  |
| `name` | `String` |  |
| `network` | `Hash` |  |
| `number` | `Integer` |  |
| `premiere_date` | `String` |  |
| `summary` | `String` |  |
| `url` | `String` |  |
| `web_channel` | `Hash` |  |

#### Example: List

```ruby
# list returns an Array of Season records (raises on error).
seasons = client.Season.list
```


### Show

Create an instance: `show = client.Show`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `average_runtime` | `Integer` |  |
| `dvd_country` | `Hash` |  |
| `ended` | `String` |  |
| `external` | `Hash` |  |
| `genre` | `Array` |  |
| `id` | `Integer` |  |
| `image` | `Hash` |  |
| `language` | `String` |  |
| `link` | `Hash` |  |
| `name` | `String` |  |
| `network` | `Hash` |  |
| `official_site` | `String` |  |
| `premiered` | `String` |  |
| `rating` | `Hash` |  |
| `runtime` | `Integer` |  |
| `schedule` | `Hash` |  |
| `score` | `Float` |  |
| `show` | `Hash` |  |
| `status` | `String` |  |
| `summary` | `String` |  |
| `type` | `String` |  |
| `updated` | `Integer` |  |
| `url` | `String` |  |
| `web_channel` | `Hash` |  |
| `weight` | `Integer` |  |

#### Example: Load

```ruby
# load returns the bare Show record (raises on error).
show = client.Show.load({ "id" => "show_id" })
```

#### Example: List

```ruby
# list returns an Array of Show records (raises on error).
shows = client.Show.list
```


### Update

Create an instance: `update = client.Update`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ruby
# load returns the bare Update record (raises on error).
update = client.Update.load()
```


## Advanced

> The sections above cover everyday use. The material below explains the
> SDK's internals — useful when extending it with custom features, but not
> needed for normal use.

### The operation pipeline

Every entity operation follows a six-stage pipeline. Each stage fires a
feature hook before executing:

```
PrePoint → PreSpec → PreRequest → PreResponse → PreResult → PreDone
```

- **PrePoint**: Resolves which API endpoint to call based on the
  operation name and entity configuration.
- **PreSpec**: Builds the HTTP spec — URL, method, headers, body —
  from the resolved point and the caller's parameters.
- **PreRequest**: Sends the HTTP request. Features can intercept here
  to replace the transport (as TestFeature does with mocks).
- **PreResponse**: Parses the raw HTTP response.
- **PreResult**: Extracts the business data from the parsed response.
- **PreDone**: Final stage before returning to the caller. Entity
  state (match, data) is updated here.

If any stage errors, the pipeline short-circuits and the error surfaces
to the caller — see [Error handling](#error-handling) for how that looks
in this language.

### Features and hooks

Features are the extension mechanism. A feature is a Ruby class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as hashes

The Ruby SDK uses plain Ruby hashes throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `Helpers.to_map()` to safely validate that a value is a hash.

### Module structure

```
rb/
├── Tvmaze_sdk.rb       -- Main SDK module
├── config.rb                  -- Configuration
├── features.rb                -- Feature factory
├── core/                      -- Core types and context
├── entity/                    -- Entity implementations
├── feature/                   -- Built-in features (Base, Test, Log)
├── utility/                   -- Utility functions and struct library
└── test/                      -- Test suites
```

The main module (`Tvmaze_sdk`) exports the SDK class
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally.

```ruby
aka = client.Aka
aka.list()

# aka.data_get now returns the aka data from the last list
# aka.match_get returns the last match criteria
```

Call `make` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
