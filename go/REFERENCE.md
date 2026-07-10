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
fmt.Println(aka.GetName()) // "aka"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country` | `map[string]any` | No |  |
| `name` | `string` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Aka(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
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
alternateList := client.AlternateList(nil)
fmt.Println(alternateList.GetName()) // "alternate_list"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `int` | No |  |
| `link` | `map[string]any` | No |  |
| `name` | `string` | No |  |
| `url` | `string` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.AlternateList(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.AlternateList(nil).Load(map[string]any{"id": 1}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
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
fmt.Println(cast.GetName()) // "cast"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `character` | `map[string]any` | No |  |
| `person` | `map[string]any` | No |  |
| `self` | `bool` | No |  |
| `voice` | `bool` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Cast(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
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
castCredit := client.CastCredit(nil)
fmt.Println(castCredit.GetName()) // "cast_credit"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | `map[string]any` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.CastCredit(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
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
castMember := client.CastMember(nil)
fmt.Println(castMember.GetName()) // "cast_member"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `character` | `map[string]any` | No |  |
| `person` | `map[string]any` | No |  |
| `self` | `bool` | No |  |
| `voice` | `bool` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.CastMember(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
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
fmt.Println(crew.GetName()) // "crew"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `person` | `map[string]any` | No |  |
| `type` | `string` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Crew(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
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
crewCredit := client.CrewCredit(nil)
fmt.Println(crewCredit.GetName()) // "crew_credit"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | `map[string]any` | No |  |
| `type` | `string` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.CrewCredit(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
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
crewMember := client.CrewMember(nil)
fmt.Println(crewMember.GetName()) // "crew_member"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `person` | `map[string]any` | No |  |
| `type` | `string` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.CrewMember(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
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
fmt.Println(episode.GetName()) // "episode"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `string` | No |  |
| `airstamp` | `string` | No |  |
| `airtime` | `string` | No |  |
| `id` | `int` | No |  |
| `image` | `map[string]any` | No |  |
| `link` | `map[string]any` | No |  |
| `name` | `string` | No |  |
| `number` | `int` | No |  |
| `rating` | `map[string]any` | No |  |
| `runtime` | `int` | No |  |
| `season` | `int` | No |  |
| `summary` | `string` | No |  |
| `type` | `string` | No |  |
| `url` | `string` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Episode(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Episode(nil).Load(map[string]any{"id": 1}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
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
guestCastCredit := client.GuestCastCredit(nil)
fmt.Println(guestCastCredit.GetName()) // "guest_cast_credit"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | `map[string]any` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.GuestCastCredit(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
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
fmt.Println(image.GetName()) // "image"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `int` | No |  |
| `main` | `bool` | No |  |
| `resolution` | `map[string]any` | No |  |
| `type` | `string` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Image(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
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
fmt.Println(person.GetName()) // "person"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday` | `string` | No |  |
| `country` | `map[string]any` | No |  |
| `deathday` | `string` | No |  |
| `gender` | `string` | No |  |
| `id` | `int` | No |  |
| `image` | `map[string]any` | No |  |
| `link` | `map[string]any` | No |  |
| `name` | `string` | No |  |
| `person` | `map[string]any` | No |  |
| `score` | `float64` | No |  |
| `updated` | `int` | No |  |
| `url` | `string` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Person(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Person(nil).Load(map[string]any{"id": 1}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
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
fmt.Println(schedule.GetName()) // "schedule"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `string` | No |  |
| `airstamp` | `string` | No |  |
| `airtime` | `string` | No |  |
| `id` | `int` | No |  |
| `image` | `map[string]any` | No |  |
| `link` | `map[string]any` | No |  |
| `name` | `string` | No |  |
| `number` | `int` | No |  |
| `rating` | `map[string]any` | No |  |
| `runtime` | `int` | No |  |
| `season` | `int` | No |  |
| `show` | `map[string]any` | No |  |
| `summary` | `string` | No |  |
| `type` | `string` | No |  |
| `url` | `string` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Schedule(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
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
scheduledEpisode := client.ScheduledEpisode(nil)
fmt.Println(scheduledEpisode.GetName()) // "scheduled_episode"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `string` | No |  |
| `airstamp` | `string` | No |  |
| `airtime` | `string` | No |  |
| `id` | `int` | No |  |
| `image` | `map[string]any` | No |  |
| `link` | `map[string]any` | No |  |
| `name` | `string` | No |  |
| `number` | `int` | No |  |
| `rating` | `map[string]any` | No |  |
| `runtime` | `int` | No |  |
| `season` | `int` | No |  |
| `show` | `map[string]any` | No |  |
| `summary` | `string` | No |  |
| `type` | `string` | No |  |
| `url` | `string` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.ScheduledEpisode(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
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
fmt.Println(search.GetName()) // "search"
```

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Search(nil).Load(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
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
fmt.Println(season.GetName()) // "season"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `end_date` | `string` | No |  |
| `episode_order` | `int` | No |  |
| `id` | `int` | No |  |
| `image` | `map[string]any` | No |  |
| `link` | `map[string]any` | No |  |
| `name` | `string` | No |  |
| `network` | `map[string]any` | No |  |
| `number` | `int` | No |  |
| `premiere_date` | `string` | No |  |
| `summary` | `string` | No |  |
| `url` | `string` | No |  |
| `web_channel` | `map[string]any` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Season(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
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
fmt.Println(show.GetName()) // "show"
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `average_runtime` | `int` | No |  |
| `dvd_country` | `map[string]any` | No |  |
| `ended` | `string` | No |  |
| `external` | `map[string]any` | No |  |
| `genre` | `[]any` | No |  |
| `id` | `int` | No |  |
| `image` | `map[string]any` | No |  |
| `language` | `string` | No |  |
| `link` | `map[string]any` | No |  |
| `name` | `string` | No |  |
| `network` | `map[string]any` | No |  |
| `official_site` | `string` | No |  |
| `premiered` | `string` | No |  |
| `rating` | `map[string]any` | No |  |
| `runtime` | `int` | No |  |
| `schedule` | `map[string]any` | No |  |
| `score` | `float64` | No |  |
| `show` | `map[string]any` | No |  |
| `status` | `string` | No |  |
| `summary` | `string` | No |  |
| `type` | `string` | No |  |
| `updated` | `int` | No |  |
| `url` | `string` | No |  |
| `web_channel` | `map[string]any` | No |  |
| `weight` | `int` | No |  |

### Operations

#### `List(reqmatch, ctrl map[string]any) (any, error)`

List entities matching the given criteria. Returns an array.

```go
results, err := client.Show(nil).List(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(results)
```

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Show(nil).Load(map[string]any{"id": 1}, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
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
fmt.Println(update.GetName()) // "update"
```

### Operations

#### `Load(reqmatch, ctrl map[string]any) (any, error)`

Load a single entity matching the given criteria.

```go
result, err := client.Update(nil).Load(nil, nil)
if err != nil {
    panic(err)
}
fmt.Println(result)
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

