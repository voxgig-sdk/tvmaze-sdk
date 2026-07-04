# Tvmaze Golang SDK Reference

Complete API reference for the Tvmaze Golang SDK.


## TvmazeSDK

### Constructor

```go
func NewTvmazeSDK(options map[string]any) *TvmazeSDK
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `map[string]any` | SDK configuration options. |
| `options["base"]` | `string` | Base URL for API requests. |
| `options["prefix"]` | `string` | URL prefix appended after base. |
| `options["suffix"]` | `string` | URL suffix appended after path. |
| `options["headers"]` | `map[string]any` | Custom headers for all requests. |
| `options["feature"]` | `map[string]any` | Feature configuration. |
| `options["system"]` | `map[string]any` | System overrides (e.g. custom fetch). |


### Static Methods

#### `Test() *TvmazeSDK`

No-arg convenience constructor for the common no-options test case.

```go
client := sdk.Test()
```

#### `TestSDK(testopts, sdkopts map[string]any) *TvmazeSDK`

Test client with options. Both arguments may be `nil`.

```go
client := sdk.TestSDK(testopts, sdkopts)
```


### Instance Methods

#### `Aka(data map[string]any) TvmazeEntity`

Create a new `Aka` entity instance. Pass `nil` for no initial data.

#### `AlternateList(data map[string]any) TvmazeEntity`

Create a new `AlternateList` entity instance. Pass `nil` for no initial data.

#### `Cast(data map[string]any) TvmazeEntity`

Create a new `Cast` entity instance. Pass `nil` for no initial data.

#### `CastCredit(data map[string]any) TvmazeEntity`

Create a new `CastCredit` entity instance. Pass `nil` for no initial data.

#### `CastMember(data map[string]any) TvmazeEntity`

Create a new `CastMember` entity instance. Pass `nil` for no initial data.

#### `Crew(data map[string]any) TvmazeEntity`

Create a new `Crew` entity instance. Pass `nil` for no initial data.

#### `CrewCredit(data map[string]any) TvmazeEntity`

Create a new `CrewCredit` entity instance. Pass `nil` for no initial data.

#### `CrewMember(data map[string]any) TvmazeEntity`

Create a new `CrewMember` entity instance. Pass `nil` for no initial data.

#### `Episode(data map[string]any) TvmazeEntity`

Create a new `Episode` entity instance. Pass `nil` for no initial data.

#### `GuestCastCredit(data map[string]any) TvmazeEntity`

Create a new `GuestCastCredit` entity instance. Pass `nil` for no initial data.

#### `Image(data map[string]any) TvmazeEntity`

Create a new `Image` entity instance. Pass `nil` for no initial data.

#### `Person(data map[string]any) TvmazeEntity`

Create a new `Person` entity instance. Pass `nil` for no initial data.

#### `Schedule(data map[string]any) TvmazeEntity`

Create a new `Schedule` entity instance. Pass `nil` for no initial data.

#### `ScheduledEpisode(data map[string]any) TvmazeEntity`

Create a new `ScheduledEpisode` entity instance. Pass `nil` for no initial data.

#### `Search(data map[string]any) TvmazeEntity`

Create a new `Search` entity instance. Pass `nil` for no initial data.

#### `Season(data map[string]any) TvmazeEntity`

Create a new `Season` entity instance. Pass `nil` for no initial data.

#### `Show(data map[string]any) TvmazeEntity`

Create a new `Show` entity instance. Pass `nil` for no initial data.

#### `Update(data map[string]any) TvmazeEntity`

Create a new `Update` entity instance. Pass `nil` for no initial data.

#### `OptionsMap() map[string]any`

Return a deep copy of the current SDK options.

#### `GetUtility() *Utility`

Return a copy of the SDK utility object.

#### `Direct(fetchargs map[string]any) (map[string]any, error)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `map[string]any` | Path parameter values for `{param}` substitution. |
| `fetchargs["query"]` | `map[string]any` | Query string parameters. |
| `fetchargs["headers"]` | `map[string]any` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (maps are JSON-serialized). |
| `fetchargs["ctrl"]` | `map[string]any` | Control options (e.g. `map[string]any{"explain": true}`). |

**Returns:** `(map[string]any, error)`

#### `Prepare(fetchargs map[string]any) (map[string]any, error)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `Direct()`.

**Returns:** `(map[string]any, error)`


---

## AkaEntity

```go
aka := client.Aka(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Aka(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `AkaEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## AlternateListEntity

```go
alternate_list := client.AlternateList(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | ``$INTEGER`` | No |  |
| `link` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |
| `url` | ``$STRING`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.AlternateList(nil).List(nil, nil)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.AlternateList(nil).Load(map[string]any{"id": "alternate_list_id"}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `AlternateListEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## CastEntity

```go
cast := client.Cast(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `character` | ``$OBJECT`` | No |  |
| `person` | ``$OBJECT`` | No |  |
| `self` | ``$BOOLEAN`` | No |  |
| `voice` | ``$BOOLEAN`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Cast(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `CastEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## CastCreditEntity

```go
cast_credit := client.CastCredit(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | ``$OBJECT`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.CastCredit(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `CastCreditEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## CastMemberEntity

```go
cast_member := client.CastMember(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `character` | ``$OBJECT`` | No |  |
| `person` | ``$OBJECT`` | No |  |
| `self` | ``$BOOLEAN`` | No |  |
| `voice` | ``$BOOLEAN`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.CastMember(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `CastMemberEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## CrewEntity

```go
crew := client.Crew(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `person` | ``$OBJECT`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Crew(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `CrewEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## CrewCreditEntity

```go
crew_credit := client.CrewCredit(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | ``$OBJECT`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.CrewCredit(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `CrewCreditEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## CrewMemberEntity

```go
crew_member := client.CrewMember(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `person` | ``$OBJECT`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.CrewMember(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `CrewMemberEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## EpisodeEntity

```go
episode := client.Episode(nil)
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

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Episode(nil).List(nil, nil)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Episode(nil).Load(map[string]any{"id": "episode_id"}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `EpisodeEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## GuestCastCreditEntity

```go
guest_cast_credit := client.GuestCastCredit(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | ``$OBJECT`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.GuestCastCredit(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `GuestCastCreditEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## ImageEntity

```go
image := client.Image(nil)
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | ``$INTEGER`` | No |  |
| `main` | ``$BOOLEAN`` | No |  |
| `resolution` | ``$OBJECT`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Image(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `ImageEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## PersonEntity

```go
person := client.Person(nil)
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

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Person(nil).List(nil, nil)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Person(nil).Load(map[string]any{"id": "person_id"}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `PersonEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## ScheduleEntity

```go
schedule := client.Schedule(nil)
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

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Schedule(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `ScheduleEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## ScheduledEpisodeEntity

```go
scheduled_episode := client.ScheduledEpisode(nil)
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

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.ScheduledEpisode(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `ScheduledEpisodeEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## SearchEntity

```go
search := client.Search(nil)
```

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Search(nil).Load(map[string]any{"id": "search_id"}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `SearchEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## SeasonEntity

```go
season := client.Season(nil)
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

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Season(nil).List(nil, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `SeasonEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## ShowEntity

```go
show := client.Show(nil)
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

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Show(nil).List(nil, nil)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Show(nil).Load(map[string]any{"id": "show_id"}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `ShowEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## UpdateEntity

```go
update := client.Update(nil)
```

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Update(nil).Load(map[string]any{"id": "update_id"}, nil)
```

### Common Methods

#### `Data(args ...any) any`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `Match(args ...any) any`

Get or set the entity match criteria. Works the same as `Data()`.

#### `Make() Entity`

Create a new `UpdateEntity` instance with the same client and
options.

#### `GetName() string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```go
client := sdk.NewTvmazeSDK(map[string]any{
    "feature": map[string]any{
        "test": map[string]any{"active": true},
    },
})
```

