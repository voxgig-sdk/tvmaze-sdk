# Tvmaze Lua SDK Reference

Complete API reference for the Tvmaze Lua SDK.


## TvmazeSDK

### Constructor

```lua
local sdk = require("tvmaze_sdk")
local client = sdk.new(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `table` | SDK configuration options. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `table` | Custom headers for all requests. |
| `options.feature` | `table` | Feature configuration. |
| `options.system` | `table` | System overrides (e.g. custom fetch). |


### Static Methods

#### `sdk.test(testopts?, sdkopts?)`

Create a test client with mock features active. Both arguments are optional.

```lua
local client = sdk.test()
```


### Instance Methods

#### `Aka(data)`

Create a new `Aka` entity instance. Pass `nil` for no initial data.

#### `AlternateList(data)`

Create a new `AlternateList` entity instance. Pass `nil` for no initial data.

#### `Cast(data)`

Create a new `Cast` entity instance. Pass `nil` for no initial data.

#### `CastCredit(data)`

Create a new `CastCredit` entity instance. Pass `nil` for no initial data.

#### `CastMember(data)`

Create a new `CastMember` entity instance. Pass `nil` for no initial data.

#### `Crew(data)`

Create a new `Crew` entity instance. Pass `nil` for no initial data.

#### `CrewCredit(data)`

Create a new `CrewCredit` entity instance. Pass `nil` for no initial data.

#### `CrewMember(data)`

Create a new `CrewMember` entity instance. Pass `nil` for no initial data.

#### `Episode(data)`

Create a new `Episode` entity instance. Pass `nil` for no initial data.

#### `GuestCastCredit(data)`

Create a new `GuestCastCredit` entity instance. Pass `nil` for no initial data.

#### `Image(data)`

Create a new `Image` entity instance. Pass `nil` for no initial data.

#### `Person(data)`

Create a new `Person` entity instance. Pass `nil` for no initial data.

#### `Schedule(data)`

Create a new `Schedule` entity instance. Pass `nil` for no initial data.

#### `ScheduledEpisode(data)`

Create a new `ScheduledEpisode` entity instance. Pass `nil` for no initial data.

#### `Search(data)`

Create a new `Search` entity instance. Pass `nil` for no initial data.

#### `Season(data)`

Create a new `Season` entity instance. Pass `nil` for no initial data.

#### `Show(data)`

Create a new `Show` entity instance. Pass `nil` for no initial data.

#### `Update(data)`

Create a new `Update` entity instance. Pass `nil` for no initial data.

#### `options_map() -> table`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs) -> table, err`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs.params` | `table` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `table` | Query string parameters. |
| `fetchargs.headers` | `table` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (tables are JSON-serialized). |
| `fetchargs.ctrl` | `table` | Control options (e.g. `{ explain = true }`). |

**Returns:** `table, err`

#### `prepare(fetchargs) -> table, err`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `table, err`


---

## AkaEntity

```lua
local aka = client:Aka(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country` | `table` | No |  |
| `name` | `string` | No | Alternate name |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Aka():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `AkaEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## AlternateListEntity

```lua
local alternate_list = client:AlternateList(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `number` | No | Unique alternate list identifier |
| `links` | `table` | No |  |
| `name` | `string` | No | Name of alternate list (e.g., DVD Order) |
| `self` | `table` | No |  |
| `url` | `string` | No | TVmaze URL for the alternate list |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:AlternateList():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:AlternateList():load({ id = 1 })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `AlternateListEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## CastEntity

```lua
local cast = client:Cast(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `character` | `table` | No |  |
| `person` | `table` | No |  |
| `self` | `boolean` | No | Whether person plays themselves |
| `voice` | `boolean` | No | Whether this is a voice role |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Cast():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CastEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## CastCreditEntity

```lua
local cast_credit = client:CastCredit(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `links` | `table` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:CastCredit():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CastCreditEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## CastMemberEntity

```lua
local cast_member = client:CastMember(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `character` | `table` | No |  |
| `person` | `table` | No |  |
| `self` | `boolean` | No | Whether person plays themselves |
| `voice` | `boolean` | No | Whether this is a voice role |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:CastMember():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CastMemberEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## CrewEntity

```lua
local crew = client:Crew(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `person` | `table` | No |  |
| `type` | `string` | No | Crew type (e.g., Executive Producer) |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Crew():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CrewEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## CrewCreditEntity

```lua
local crew_credit = client:CrewCredit(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `links` | `table` | No |  |
| `type` | `string` | No | Crew type |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:CrewCredit():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CrewCreditEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## CrewMemberEntity

```lua
local crew_member = client:CrewMember(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `person` | `table` | No |  |
| `type` | `string` | No | Crew type (e.g., Executive Producer) |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:CrewMember():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CrewMemberEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## EpisodeEntity

```lua
local episode = client:Episode(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `string` | No | Air date |
| `airstamp` | `string` | No | Air timestamp |
| `airtime` | `string` | No | Air time |
| `id` | `number` | No | Unique episode identifier |
| `image` | `table` | No |  |
| `links` | `table` | No |  |
| `name` | `string` | No | Episode name |
| `number` | `number` | No | Episode number in season |
| `rating` | `table` | No |  |
| `runtime` | `number` | No | Runtime in minutes |
| `season` | `number` | No | Season number |
| `summary` | `string` | No | HTML summary |
| `type` | `string` | No | Episode type (e.g., regular, significant_special) |
| `url` | `string` | No | TVmaze URL for the episode |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Episode():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Episode():load({ id = 1 })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `EpisodeEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## GuestCastCreditEntity

```lua
local guest_cast_credit = client:GuestCastCredit(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `links` | `table` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:GuestCastCredit():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `GuestCastCreditEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## ImageEntity

```lua
local image = client:Image(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `number` | No | Unique image identifier |
| `main` | `boolean` | No | Whether this is the main image |
| `resolutions` | `table` | No |  |
| `type` | `string` | No | Image type |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Image():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ImageEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## PersonEntity

```lua
local person = client:Person(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday` | `string` | No | Birth date |
| `country` | `table` | No |  |
| `deathday` | `string` | No | Death date |
| `gender` | `string` | No | Gender |
| `id` | `number` | No | Unique person identifier |
| `image` | `table` | No |  |
| `links` | `table` | No |  |
| `name` | `string` | No | Person name |
| `person` | `table` | No |  |
| `score` | `number` | No | Search relevancy score |
| `updated` | `number` | No | Unix timestamp of last update |
| `url` | `string` | No | TVmaze URL for the person |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Person():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Person():load({ id = 1 })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `PersonEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## ScheduleEntity

```lua
local schedule = client:Schedule(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `string` | No | Air date |
| `airstamp` | `string` | No | Air timestamp |
| `airtime` | `string` | No | Air time |
| `id` | `number` | No | Unique episode identifier |
| `image` | `table` | No |  |
| `links` | `table` | No |  |
| `name` | `string` | No | Episode name |
| `number` | `number` | No | Episode number in season |
| `rating` | `table` | No |  |
| `runtime` | `number` | No | Runtime in minutes |
| `season` | `number` | No | Season number |
| `show` | `table` | No |  |
| `summary` | `string` | No | HTML summary |
| `type` | `string` | No | Episode type (e.g., regular, significant_special) |
| `url` | `string` | No | TVmaze URL for the episode |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Schedule():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ScheduleEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## ScheduledEpisodeEntity

```lua
local scheduled_episode = client:ScheduledEpisode(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `string` | No | Air date |
| `airstamp` | `string` | No | Air timestamp |
| `airtime` | `string` | No | Air time |
| `id` | `number` | No | Unique episode identifier |
| `image` | `table` | No |  |
| `links` | `table` | No |  |
| `name` | `string` | No | Episode name |
| `number` | `number` | No | Episode number in season |
| `rating` | `table` | No |  |
| `runtime` | `number` | No | Runtime in minutes |
| `season` | `number` | No | Season number |
| `show` | `table` | No |  |
| `summary` | `string` | No | HTML summary |
| `type` | `string` | No | Episode type (e.g., regular, significant_special) |
| `url` | `string` | No | TVmaze URL for the episode |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:ScheduledEpisode():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ScheduledEpisodeEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## SearchEntity

```lua
local search = client:Search(nil)
```

### Operations

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Search():load()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SearchEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## SeasonEntity

```lua
local season = client:Season(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `endDate` | `string` | No | End date |
| `episodeOrder` | `number` | No | Number of episodes |
| `id` | `number` | No | Unique season identifier |
| `image` | `table` | No |  |
| `links` | `table` | No |  |
| `name` | `string` | No | Season name |
| `network` | `table` | No |  |
| `number` | `number` | No | Season number |
| `premiereDate` | `string` | No | Premiere date |
| `summary` | `string` | No | HTML summary |
| `url` | `string` | No | TVmaze URL for the season |
| `webChannel` | `table` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Season():list()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SeasonEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## ShowEntity

```lua
local show = client:Show(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `averageRuntime` | `number` | No | Average runtime in minutes |
| `dvdCountry` | `table` | No |  |
| `ended` | `string` | No | End date |
| `externals` | `table` | No |  |
| `genres` | `table` | No | List of genres |
| `id` | `number` | No | Unique show identifier |
| `image` | `table` | No |  |
| `language` | `string` | No | Original language |
| `links` | `table` | No |  |
| `name` | `string` | No | Show name |
| `network` | `table` | No |  |
| `officialSite` | `string` | No | Official website URL |
| `premiered` | `string` | No | Premiere date |
| `rating` | `table` | No |  |
| `runtime` | `number` | No | Runtime in minutes |
| `schedule` | `table` | No |  |
| `score` | `number` | No | Search relevancy score |
| `show` | `table` | No |  |
| `status` | `string` | No | Current status (e.g., Running, Ended) |
| `summary` | `string` | No | HTML summary |
| `type` | `string` | No | Show type (e.g., Scripted, Reality) |
| `updated` | `number` | No | Unix timestamp of last update |
| `url` | `string` | No | TVmaze URL for the show |
| `webChannel` | `table` | No |  |
| `weight` | `number` | No | Show weight/importance |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Show():list()
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Show():load({ id = 1 })
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ShowEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## UpdateEntity

```lua
local update = client:Update(nil)
```

### Operations

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Update():load()
```

### Common Methods

#### `data_get() -> table`

Get the entity data. Returns a copy of the current data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> table`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `UpdateEntity` instance with the same client and
options.

#### `get_name() -> string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```lua
local client = sdk.new({
  feature = {
    test = { active = true },
  },
})
```


### Configuring features

Each feature is inactive until switched on, and an SDK with no feature
configured does no feature work at all. Every option below keeps its default
unless you name it.

The array form of \`feature\` is significant: several features wrap the
transport, and the order you list them in is the order they nest.

#### `test`

In-memory mock transport for testing without a live server.

**Configuration**

| Option | Default |
|---|---|
| `active` | `false` |

Options above are those the model carries a default for. A feature may
also accept callback options — a `sink` to receive each record, for
instance — which have no default and are covered in the full feature
reference.

**Usage**

Set `feature.test.active` to true in the client options, and override any option above in the same entry. Every option keeps
its default unless you name it.

**Considerations**

- Attaches to pipeline hooks, not the transport, so activation order does
  not change what it observes.
- Installs the BASE transport that the wrapping features wrap, so it must be
  activated before them.
- Inactive by default: leaving it out costs nothing at runtime.

