# Tvmaze Ruby SDK Reference

Complete API reference for the Tvmaze Ruby SDK.


## TvmazeSDK

### Constructor

```ruby
require_relative 'Tvmaze_sdk'

client = TvmazeSDK.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `Hash` | SDK configuration options. |
| `options["base"]` | `String` | Base URL for API requests. |
| `options["prefix"]` | `String` | URL prefix appended after base. |
| `options["suffix"]` | `String` | URL suffix appended after path. |
| `options["headers"]` | `Hash` | Custom headers for all requests. |
| `options["feature"]` | `Hash` | Feature configuration. |
| `options["system"]` | `Hash` | System overrides (e.g. custom fetch). |


### Static Methods

#### `TvmazeSDK.test(testopts = nil, sdkopts = nil)`

Create a test client with mock features active. Both arguments may be `nil`.

```ruby
client = TvmazeSDK.test
```


### Instance Methods

#### `Aka(data = nil)`

Create a new `Aka` entity instance. Pass `nil` for no initial data.

#### `AlternateList(data = nil)`

Create a new `AlternateList` entity instance. Pass `nil` for no initial data.

#### `Cast(data = nil)`

Create a new `Cast` entity instance. Pass `nil` for no initial data.

#### `CastCredit(data = nil)`

Create a new `CastCredit` entity instance. Pass `nil` for no initial data.

#### `CastMember(data = nil)`

Create a new `CastMember` entity instance. Pass `nil` for no initial data.

#### `Crew(data = nil)`

Create a new `Crew` entity instance. Pass `nil` for no initial data.

#### `CrewCredit(data = nil)`

Create a new `CrewCredit` entity instance. Pass `nil` for no initial data.

#### `CrewMember(data = nil)`

Create a new `CrewMember` entity instance. Pass `nil` for no initial data.

#### `Episode(data = nil)`

Create a new `Episode` entity instance. Pass `nil` for no initial data.

#### `GuestCastCredit(data = nil)`

Create a new `GuestCastCredit` entity instance. Pass `nil` for no initial data.

#### `Image(data = nil)`

Create a new `Image` entity instance. Pass `nil` for no initial data.

#### `Person(data = nil)`

Create a new `Person` entity instance. Pass `nil` for no initial data.

#### `Schedule(data = nil)`

Create a new `Schedule` entity instance. Pass `nil` for no initial data.

#### `ScheduledEpisode(data = nil)`

Create a new `ScheduledEpisode` entity instance. Pass `nil` for no initial data.

#### `Search(data = nil)`

Create a new `Search` entity instance. Pass `nil` for no initial data.

#### `Season(data = nil)`

Create a new `Season` entity instance. Pass `nil` for no initial data.

#### `Show(data = nil)`

Create a new `Show` entity instance. Pass `nil` for no initial data.

#### `Update(data = nil)`

Create a new `Update` entity instance. Pass `nil` for no initial data.

#### `options_map -> Hash`

Return a deep copy of the current SDK options.

#### `get_utility -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs = {}) -> Hash`

Make a direct HTTP request to any API endpoint. Returns a result hash
(`{ "ok" => ..., "status" => ..., "data" => ..., "err" => ... }`); it
does not raise — inspect `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `String` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `String` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `Hash` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `Hash` | Query string parameters. |
| `fetchargs["headers"]` | `Hash` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (hashes are JSON-serialized). |
| `fetchargs["ctrl"]` | `Hash` | Control options (e.g. `{ "explain" => true }`). |

**Returns:** `Hash`

#### `prepare(fetchargs = {}) -> Hash`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`. Raises on error.

**Returns:** `Hash` (the fetch definition; raises on error)


---

## AkaEntity

```ruby
aka = client.Aka
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country` | `Hash` | No |  |
| `name` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Aka.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `AkaEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## AlternateListEntity

```ruby
alternate_list = client.AlternateList
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `Integer` | No |  |
| `link` | `Hash` | No |  |
| `name` | `String` | No |  |
| `url` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.AlternateList.list
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.AlternateList.load({ "id" => 1 })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `AlternateListEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## CastEntity

```ruby
cast = client.Cast
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `character` | `Hash` | No |  |
| `person` | `Hash` | No |  |
| `self` | `Boolean` | No |  |
| `voice` | `Boolean` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Cast.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `CastEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## CastCreditEntity

```ruby
cast_credit = client.CastCredit
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | `Hash` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.CastCredit.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `CastCreditEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## CastMemberEntity

```ruby
cast_member = client.CastMember
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `character` | `Hash` | No |  |
| `person` | `Hash` | No |  |
| `self` | `Boolean` | No |  |
| `voice` | `Boolean` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.CastMember.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `CastMemberEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## CrewEntity

```ruby
crew = client.Crew
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `person` | `Hash` | No |  |
| `type` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Crew.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `CrewEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## CrewCreditEntity

```ruby
crew_credit = client.CrewCredit
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | `Hash` | No |  |
| `type` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.CrewCredit.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `CrewCreditEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## CrewMemberEntity

```ruby
crew_member = client.CrewMember
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `person` | `Hash` | No |  |
| `type` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.CrewMember.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `CrewMemberEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## EpisodeEntity

```ruby
episode = client.Episode
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `String` | No |  |
| `airstamp` | `String` | No |  |
| `airtime` | `String` | No |  |
| `id` | `Integer` | No |  |
| `image` | `Hash` | No |  |
| `link` | `Hash` | No |  |
| `name` | `String` | No |  |
| `number` | `Integer` | No |  |
| `rating` | `Hash` | No |  |
| `runtime` | `Integer` | No |  |
| `season` | `Integer` | No |  |
| `summary` | `String` | No |  |
| `type` | `String` | No |  |
| `url` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Episode.list
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Episode.load({ "id" => 1 })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `EpisodeEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## GuestCastCreditEntity

```ruby
guest_cast_credit = client.GuestCastCredit
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | `Hash` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.GuestCastCredit.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `GuestCastCreditEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ImageEntity

```ruby
image = client.Image
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `Integer` | No |  |
| `main` | `Boolean` | No |  |
| `resolution` | `Hash` | No |  |
| `type` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Image.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ImageEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## PersonEntity

```ruby
person = client.Person
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday` | `String` | No |  |
| `country` | `Hash` | No |  |
| `deathday` | `String` | No |  |
| `gender` | `String` | No |  |
| `id` | `Integer` | No |  |
| `image` | `Hash` | No |  |
| `link` | `Hash` | No |  |
| `name` | `String` | No |  |
| `person` | `Hash` | No |  |
| `score` | `Float` | No |  |
| `updated` | `Integer` | No |  |
| `url` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Person.list
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Person.load({ "id" => 1 })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `PersonEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ScheduleEntity

```ruby
schedule = client.Schedule
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `String` | No |  |
| `airstamp` | `String` | No |  |
| `airtime` | `String` | No |  |
| `id` | `Integer` | No |  |
| `image` | `Hash` | No |  |
| `link` | `Hash` | No |  |
| `name` | `String` | No |  |
| `number` | `Integer` | No |  |
| `rating` | `Hash` | No |  |
| `runtime` | `Integer` | No |  |
| `season` | `Integer` | No |  |
| `show` | `Hash` | No |  |
| `summary` | `String` | No |  |
| `type` | `String` | No |  |
| `url` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Schedule.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ScheduleEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ScheduledEpisodeEntity

```ruby
scheduled_episode = client.ScheduledEpisode
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `String` | No |  |
| `airstamp` | `String` | No |  |
| `airtime` | `String` | No |  |
| `id` | `Integer` | No |  |
| `image` | `Hash` | No |  |
| `link` | `Hash` | No |  |
| `name` | `String` | No |  |
| `number` | `Integer` | No |  |
| `rating` | `Hash` | No |  |
| `runtime` | `Integer` | No |  |
| `season` | `Integer` | No |  |
| `show` | `Hash` | No |  |
| `summary` | `String` | No |  |
| `type` | `String` | No |  |
| `url` | `String` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.ScheduledEpisode.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ScheduledEpisodeEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## SearchEntity

```ruby
search = client.Search
```

### Operations

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Search.load()
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `SearchEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## SeasonEntity

```ruby
season = client.Season
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `end_date` | `String` | No |  |
| `episode_order` | `Integer` | No |  |
| `id` | `Integer` | No |  |
| `image` | `Hash` | No |  |
| `link` | `Hash` | No |  |
| `name` | `String` | No |  |
| `network` | `Hash` | No |  |
| `number` | `Integer` | No |  |
| `premiere_date` | `String` | No |  |
| `summary` | `String` | No |  |
| `url` | `String` | No |  |
| `web_channel` | `Hash` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Season.list
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `SeasonEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## ShowEntity

```ruby
show = client.Show
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `average_runtime` | `Integer` | No |  |
| `dvd_country` | `Hash` | No |  |
| `ended` | `String` | No |  |
| `external` | `Hash` | No |  |
| `genre` | `Array` | No |  |
| `id` | `Integer` | No |  |
| `image` | `Hash` | No |  |
| `language` | `String` | No |  |
| `link` | `Hash` | No |  |
| `name` | `String` | No |  |
| `network` | `Hash` | No |  |
| `official_site` | `String` | No |  |
| `premiered` | `String` | No |  |
| `rating` | `Hash` | No |  |
| `runtime` | `Integer` | No |  |
| `schedule` | `Hash` | No |  |
| `score` | `Float` | No |  |
| `show` | `Hash` | No |  |
| `status` | `String` | No |  |
| `summary` | `String` | No |  |
| `type` | `String` | No |  |
| `updated` | `Integer` | No |  |
| `url` | `String` | No |  |
| `web_channel` | `Hash` | No |  |
| `weight` | `Integer` | No |  |

### Operations

#### `list(reqmatch = nil, ctrl = nil) -> Array`

List entities matching the given criteria (call with no argument to list all). Returns an array. Raises on error.

```ruby
results = client.Show.list
```

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Show.load({ "id" => 1 })
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `ShowEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## UpdateEntity

```ruby
update = client.Update
```

### Operations

#### `load(reqmatch, ctrl = nil) -> result`

Load a single entity matching the given criteria. Raises on error.

```ruby
result = client.Update.load()
```

### Common Methods

#### `data_get -> Hash`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get -> Hash`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make -> Entity`

Create a new `UpdateEntity` instance with the same client and
options.

#### `get_name -> String`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ruby
client = TvmazeSDK.new({
  "feature" => {
    "test" => { "active" => true },
  },
})
```

