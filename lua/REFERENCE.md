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
| `options.apikey` | `string` | API key for authentication. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `table` | Custom headers for all requests. |
| `options.feature` | `table` | Feature configuration. |
| `options.system` | `table` | System overrides (e.g. custom fetch). |


### Static Methods

#### `sdk.test(testopts, sdkopts)`

Create a test client with mock features active. Both arguments may be `nil`.

```lua
local client = sdk.test(nil, nil)
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
| `country` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Aka(nil):list(nil, nil)
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
| `id` | ``$INTEGER`` | No |  |
| `link` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |
| `url` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:AlternateList(nil):list(nil, nil)
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:AlternateList(nil):load({ id = "alternate_list_id" }, nil)
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
| `character` | ``$OBJECT`` | No |  |
| `person` | ``$OBJECT`` | No |  |
| `self` | ``$BOOLEAN`` | No |  |
| `voice` | ``$BOOLEAN`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Cast(nil):list(nil, nil)
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
| `link` | ``$OBJECT`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:CastCredit(nil):list(nil, nil)
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
| `character` | ``$OBJECT`` | No |  |
| `person` | ``$OBJECT`` | No |  |
| `self` | ``$BOOLEAN`` | No |  |
| `voice` | ``$BOOLEAN`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:CastMember(nil):list(nil, nil)
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
| `person` | ``$OBJECT`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Crew(nil):list(nil, nil)
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
| `link` | ``$OBJECT`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:CrewCredit(nil):list(nil, nil)
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
| `person` | ``$OBJECT`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:CrewMember(nil):list(nil, nil)
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
| `airdate` | ``$STRING`` | No |  |
| `airstamp` | ``$STRING`` | No |  |
| `airtime` | ``$STRING`` | No |  |
| `id` | ``$INTEGER`` | No |  |
| `image` | ``$OBJECT`` | No |  |
| `link` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |
| `number` | ``$INTEGER`` | No |  |
| `rating` | ``$OBJECT`` | No |  |
| `runtime` | ``$INTEGER`` | No |  |
| `season` | ``$INTEGER`` | No |  |
| `summary` | ``$STRING`` | No |  |
| `type` | ``$STRING`` | No |  |
| `url` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Episode(nil):list(nil, nil)
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Episode(nil):load({ id = "episode_id" }, nil)
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
| `link` | ``$OBJECT`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:GuestCastCredit(nil):list(nil, nil)
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
| `id` | ``$INTEGER`` | No |  |
| `main` | ``$BOOLEAN`` | No |  |
| `resolution` | ``$OBJECT`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Image(nil):list(nil, nil)
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
| `birthday` | ``$STRING`` | No |  |
| `country` | ``$OBJECT`` | No |  |
| `deathday` | ``$STRING`` | No |  |
| `gender` | ``$STRING`` | No |  |
| `id` | ``$INTEGER`` | No |  |
| `image` | ``$OBJECT`` | No |  |
| `link` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |
| `person` | ``$OBJECT`` | No |  |
| `score` | ``$NUMBER`` | No |  |
| `updated` | ``$INTEGER`` | No |  |
| `url` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Person(nil):list(nil, nil)
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Person(nil):load({ id = "person_id" }, nil)
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
| `airdate` | ``$STRING`` | No |  |
| `airstamp` | ``$STRING`` | No |  |
| `airtime` | ``$STRING`` | No |  |
| `id` | ``$INTEGER`` | No |  |
| `image` | ``$OBJECT`` | No |  |
| `link` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |
| `number` | ``$INTEGER`` | No |  |
| `rating` | ``$OBJECT`` | No |  |
| `runtime` | ``$INTEGER`` | No |  |
| `season` | ``$INTEGER`` | No |  |
| `show` | ``$OBJECT`` | No |  |
| `summary` | ``$STRING`` | No |  |
| `type` | ``$STRING`` | No |  |
| `url` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Schedule(nil):list(nil, nil)
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
| `airdate` | ``$STRING`` | No |  |
| `airstamp` | ``$STRING`` | No |  |
| `airtime` | ``$STRING`` | No |  |
| `id` | ``$INTEGER`` | No |  |
| `image` | ``$OBJECT`` | No |  |
| `link` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |
| `number` | ``$INTEGER`` | No |  |
| `rating` | ``$OBJECT`` | No |  |
| `runtime` | ``$INTEGER`` | No |  |
| `season` | ``$INTEGER`` | No |  |
| `show` | ``$OBJECT`` | No |  |
| `summary` | ``$STRING`` | No |  |
| `type` | ``$STRING`` | No |  |
| `url` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:ScheduledEpisode(nil):list(nil, nil)
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
local result, err = client:Search(nil):load({ id = "search_id" }, nil)
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
| `end_date` | ``$STRING`` | No |  |
| `episode_order` | ``$INTEGER`` | No |  |
| `id` | ``$INTEGER`` | No |  |
| `image` | ``$OBJECT`` | No |  |
| `link` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |
| `network` | ``$OBJECT`` | No |  |
| `number` | ``$INTEGER`` | No |  |
| `premiere_date` | ``$STRING`` | No |  |
| `summary` | ``$STRING`` | No |  |
| `url` | ``$STRING`` | No |  |
| `web_channel` | ``$OBJECT`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Season(nil):list(nil, nil)
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
| `average_runtime` | ``$INTEGER`` | No |  |
| `dvd_country` | ``$OBJECT`` | No |  |
| `ended` | ``$STRING`` | No |  |
| `external` | ``$OBJECT`` | No |  |
| `genre` | ``$ARRAY`` | No |  |
| `id` | ``$INTEGER`` | No |  |
| `image` | ``$OBJECT`` | No |  |
| `language` | ``$STRING`` | No |  |
| `link` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |
| `network` | ``$OBJECT`` | No |  |
| `official_site` | ``$STRING`` | No |  |
| `premiered` | ``$STRING`` | No |  |
| `rating` | ``$OBJECT`` | No |  |
| `runtime` | ``$INTEGER`` | No |  |
| `schedule` | ``$OBJECT`` | No |  |
| `score` | ``$NUMBER`` | No |  |
| `show` | ``$OBJECT`` | No |  |
| `status` | ``$STRING`` | No |  |
| `summary` | ``$STRING`` | No |  |
| `type` | ``$STRING`` | No |  |
| `updated` | ``$INTEGER`` | No |  |
| `url` | ``$STRING`` | No |  |
| `web_channel` | ``$OBJECT`` | No |  |
| `weight` | ``$INTEGER`` | No |  |

### Operations

#### `list(reqmatch, ctrl) -> any, err`

List entities matching the given criteria. Returns an array.

```lua
local results, err = client:Show(nil):list(nil, nil)
```

#### `load(reqmatch, ctrl) -> any, err`

Load a single entity matching the given criteria.

```lua
local result, err = client:Show(nil):load({ id = "show_id" }, nil)
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
local result, err = client:Update(nil):load({ id = "update_id" }, nil)
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

