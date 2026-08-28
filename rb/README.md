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
  images = client.Image.list()
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

# Entity ops return the ENTITY (raises on error);
# call data_get for the mock record.
image = client.Image.list()
puts image
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
| `name` | Alternate name |

Operations: List.

API path: `/shows/{id}/akas`

#### AlternateList

| Field | Description |
| --- | --- |
| `id` | Unique alternate list identifier |
| `links` |  |
| `name` | Name of alternate list (e.g., DVD Order) |
| `self` |  |
| `url` | TVmaze URL for the alternate list |

Operations: List, Load.

API path: `/shows/{id}/alternatelists`

#### Cast

| Field | Description |
| --- | --- |
| `character` |  |
| `person` |  |
| `self` | Whether person plays themselves |
| `voice` | Whether this is a voice role |

Operations: List.

API path: `/shows/{id}/cast`

#### CastCredit

| Field | Description |
| --- | --- |
| `links` |  |

Operations: List.

API path: `/people/{id}/castcredits`

#### CastMember

| Field | Description |
| --- | --- |
| `character` |  |
| `person` |  |
| `self` | Whether person plays themselves |
| `voice` | Whether this is a voice role |

Operations: List.

API path: `/episodes/{id}/guestcast`

#### Crew

| Field | Description |
| --- | --- |
| `person` |  |
| `type` | Crew type (e.g., Executive Producer) |

Operations: List.

API path: `/shows/{id}/crew`

#### CrewCredit

| Field | Description |
| --- | --- |
| `links` |  |
| `type` | Crew type |

Operations: List.

API path: `/people/{id}/crewcredits`

#### CrewMember

| Field | Description |
| --- | --- |
| `person` |  |
| `type` | Crew type (e.g., Executive Producer) |

Operations: List.

API path: `/episodes/{id}/guestcrew`

#### Episode

| Field | Description |
| --- | --- |
| `airdate` | Air date |
| `airstamp` | Air timestamp |
| `airtime` | Air time |
| `id` | Unique episode identifier |
| `image` |  |
| `links` |  |
| `name` | Episode name |
| `number` | Episode number in season |
| `rating` |  |
| `runtime` | Runtime in minutes |
| `season` | Season number |
| `summary` | HTML summary |
| `type` | Episode type (e.g., regular, significant_special) |
| `url` | TVmaze URL for the episode |

Operations: List, Load.

API path: `/shows/{id}/episodesbydate`

#### GuestCastCredit

| Field | Description |
| --- | --- |
| `links` |  |

Operations: List.

API path: `/people/{id}/guestcastcredits`

#### Image

| Field | Description |
| --- | --- |
| `id` | Unique image identifier |
| `main` | Whether this is the main image |
| `resolutions` |  |
| `type` | Image type |

Operations: List.

API path: `/shows/{id}/images`

#### Person

| Field | Description |
| --- | --- |
| `birthday` | Birth date |
| `country` |  |
| `deathday` | Death date |
| `gender` | Gender |
| `id` | Unique person identifier |
| `image` |  |
| `links` |  |
| `name` | Person name |
| `person` |  |
| `score` | Search relevancy score |
| `updated` | Unix timestamp of last update |
| `url` | TVmaze URL for the person |

Operations: List, Load.

API path: `/people`

#### Schedule

| Field | Description |
| --- | --- |
| `airdate` | Air date |
| `airstamp` | Air timestamp |
| `airtime` | Air time |
| `id` | Unique episode identifier |
| `image` |  |
| `links` |  |
| `name` | Episode name |
| `number` | Episode number in season |
| `rating` |  |
| `runtime` | Runtime in minutes |
| `season` | Season number |
| `show` |  |
| `summary` | HTML summary |
| `type` | Episode type (e.g., regular, significant_special) |
| `url` | TVmaze URL for the episode |

Operations: List.

API path: `/schedule`

#### ScheduledEpisode

| Field | Description |
| --- | --- |
| `airdate` | Air date |
| `airstamp` | Air timestamp |
| `airtime` | Air time |
| `id` | Unique episode identifier |
| `image` |  |
| `links` |  |
| `name` | Episode name |
| `number` | Episode number in season |
| `rating` |  |
| `runtime` | Runtime in minutes |
| `season` | Season number |
| `show` |  |
| `summary` | HTML summary |
| `type` | Episode type (e.g., regular, significant_special) |
| `url` | TVmaze URL for the episode |

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
| `endDate` | End date |
| `episodeOrder` | Number of episodes |
| `id` | Unique season identifier |
| `image` |  |
| `links` |  |
| `name` | Season name |
| `network` |  |
| `number` | Season number |
| `premiereDate` | Premiere date |
| `summary` | HTML summary |
| `url` | TVmaze URL for the season |
| `webChannel` |  |

Operations: List.

API path: `/shows/{id}/seasons`

#### Show

| Field | Description |
| --- | --- |
| `averageRuntime` | Average runtime in minutes |
| `dvdCountry` |  |
| `ended` | End date |
| `externals` |  |
| `genres` | List of genres |
| `id` | Unique show identifier |
| `image` |  |
| `language` | Original language |
| `links` |  |
| `name` | Show name |
| `network` |  |
| `officialSite` | Official website URL |
| `premiered` | Premiere date |
| `rating` |  |
| `runtime` | Runtime in minutes |
| `schedule` |  |
| `score` | Search relevancy score |
| `show` |  |
| `status` | Current status (e.g., Running, Ended) |
| `summary` | HTML summary |
| `type` | Show type (e.g., Scripted, Reality) |
| `updated` | Unix timestamp of last update |
| `url` | TVmaze URL for the show |
| `webChannel` |  |
| `weight` | Show weight/importance |

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
| `name` | `String` | Alternate name |

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
| `id` | `Integer` | Unique alternate list identifier |
| `links` | `Hash` |  |
| `name` | `String` | Name of alternate list (e.g., DVD Order) |
| `self` | `Hash` |  |
| `url` | `String` | TVmaze URL for the alternate list |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the AlternateList record (raises on error).
alternate_list = client.AlternateList.load({ "id" => 1 })
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
| `self` | `Boolean` | Whether person plays themselves |
| `voice` | `Boolean` | Whether this is a voice role |

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
| `links` | `Hash` |  |

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
| `self` | `Boolean` | Whether person plays themselves |
| `voice` | `Boolean` | Whether this is a voice role |

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
| `type` | `String` | Crew type (e.g., Executive Producer) |

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
| `links` | `Hash` |  |
| `type` | `String` | Crew type |

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
| `type` | `String` | Crew type (e.g., Executive Producer) |

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
| `airdate` | `String` | Air date |
| `airstamp` | `String` | Air timestamp |
| `airtime` | `String` | Air time |
| `id` | `Integer` | Unique episode identifier |
| `image` | `Hash` |  |
| `links` | `Hash` |  |
| `name` | `String` | Episode name |
| `number` | `Integer` | Episode number in season |
| `rating` | `Hash` |  |
| `runtime` | `Integer` | Runtime in minutes |
| `season` | `Integer` | Season number |
| `summary` | `String` | HTML summary |
| `type` | `String` | Episode type (e.g., regular, significant_special) |
| `url` | `String` | TVmaze URL for the episode |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Episode record (raises on error).
episode = client.Episode.load({ "id" => 1 })
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
| `links` | `Hash` |  |

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
| `id` | `Integer` | Unique image identifier |
| `main` | `Boolean` | Whether this is the main image |
| `resolutions` | `Hash` |  |
| `type` | `String` | Image type |

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
| `birthday` | `String` | Birth date |
| `country` | `Hash` |  |
| `deathday` | `String` | Death date |
| `gender` | `String` | Gender |
| `id` | `Integer` | Unique person identifier |
| `image` | `Hash` |  |
| `links` | `Hash` |  |
| `name` | `String` | Person name |
| `person` | `Hash` |  |
| `score` | `Float` | Search relevancy score |
| `updated` | `Integer` | Unix timestamp of last update |
| `url` | `String` | TVmaze URL for the person |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Person record (raises on error).
person = client.Person.load({ "id" => 1 })
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
| `airdate` | `String` | Air date |
| `airstamp` | `String` | Air timestamp |
| `airtime` | `String` | Air time |
| `id` | `Integer` | Unique episode identifier |
| `image` | `Hash` |  |
| `links` | `Hash` |  |
| `name` | `String` | Episode name |
| `number` | `Integer` | Episode number in season |
| `rating` | `Hash` |  |
| `runtime` | `Integer` | Runtime in minutes |
| `season` | `Integer` | Season number |
| `show` | `Hash` |  |
| `summary` | `String` | HTML summary |
| `type` | `String` | Episode type (e.g., regular, significant_special) |
| `url` | `String` | TVmaze URL for the episode |

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
| `airdate` | `String` | Air date |
| `airstamp` | `String` | Air timestamp |
| `airtime` | `String` | Air time |
| `id` | `Integer` | Unique episode identifier |
| `image` | `Hash` |  |
| `links` | `Hash` |  |
| `name` | `String` | Episode name |
| `number` | `Integer` | Episode number in season |
| `rating` | `Hash` |  |
| `runtime` | `Integer` | Runtime in minutes |
| `season` | `Integer` | Season number |
| `show` | `Hash` |  |
| `summary` | `String` | HTML summary |
| `type` | `String` | Episode type (e.g., regular, significant_special) |
| `url` | `String` | TVmaze URL for the episode |

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
# load returns the ENTITY — call data_get for the Search record (raises on error).
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
| `endDate` | `String` | End date |
| `episodeOrder` | `Integer` | Number of episodes |
| `id` | `Integer` | Unique season identifier |
| `image` | `Hash` |  |
| `links` | `Hash` |  |
| `name` | `String` | Season name |
| `network` | `Hash` |  |
| `number` | `Integer` | Season number |
| `premiereDate` | `String` | Premiere date |
| `summary` | `String` | HTML summary |
| `url` | `String` | TVmaze URL for the season |
| `webChannel` | `Hash` |  |

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
| `averageRuntime` | `Integer` | Average runtime in minutes |
| `dvdCountry` | `Hash` |  |
| `ended` | `String` | End date |
| `externals` | `Hash` |  |
| `genres` | `Array` | List of genres |
| `id` | `Integer` | Unique show identifier |
| `image` | `Hash` |  |
| `language` | `String` | Original language |
| `links` | `Hash` |  |
| `name` | `String` | Show name |
| `network` | `Hash` |  |
| `officialSite` | `String` | Official website URL |
| `premiered` | `String` | Premiere date |
| `rating` | `Hash` |  |
| `runtime` | `Integer` | Runtime in minutes |
| `schedule` | `Hash` |  |
| `score` | `Float` | Search relevancy score |
| `show` | `Hash` |  |
| `status` | `String` | Current status (e.g., Running, Ended) |
| `summary` | `String` | HTML summary |
| `type` | `String` | Show type (e.g., Scripted, Reality) |
| `updated` | `Integer` | Unix timestamp of last update |
| `url` | `String` | TVmaze URL for the show |
| `webChannel` | `Hash` |  |
| `weight` | `Integer` | Show weight/importance |

#### Example: Load

```ruby
# load returns the ENTITY — call data_get for the Show record (raises on error).
show = client.Show.load({ "id" => 1 })
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
# load returns the ENTITY — call data_get for the Update record (raises on error).
update = client.Update.load()
```

## Features

This SDK ships 1 optional features. Each is **inactive until you
switch it on**, so an SDK you have not configured behaves exactly as if none of
them existed — no retries, no cache, no logging, no measurable overhead.

Activate a feature by name in the client options, alongside the options shown
above:

| Feature | What it does |
|---|---|
| [`test`](#test) | In-memory mock transport for testing without a live server |

### test

In-memory mock transport for testing without a live server.

| Option | Default |
|---|---|
| `active` | `false` |

Set `feature.test.active` to enable it, then override any of the options above.


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
image = client.Image
image.list()

# image.data_get now returns the image data from the last list
# image.match_get returns the last match criteria
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
