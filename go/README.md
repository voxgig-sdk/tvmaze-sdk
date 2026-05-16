# Tvmaze Golang SDK

The Golang SDK for the Tvmaze API. Provides an entity-oriented interface using standard Go conventions — no generics required, data flows as `map[string]any`.


## Install
```bash
go get github.com/voxgig-sdk/tvmaze-sdk
```

If the module is not yet published to a registry, use a `replace` directive
in your `go.mod` to point to a local checkout:

```bash
go mod edit -replace github.com/voxgig-sdk/tvmaze-sdk=../path/to/github.com/voxgig-sdk/tvmaze-sdk
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```go
package main

import (
    "fmt"
    "os"

    sdk "github.com/voxgig-sdk/tvmaze-sdk"
    "github.com/voxgig-sdk/tvmaze-sdk/core"
)

func main() {
    client := sdk.NewTvmazeSDK(map[string]any{
        "apikey": os.Getenv("TVMAZE_APIKEY"),
    })
```

### 2. List akas

```go
    result, err := client.Aka(nil).List(nil, nil)
    if err != nil {
        panic(err)
    }

    rm := core.ToMapAny(result)
    if rm["ok"] == true {
        for _, item := range rm["data"].([]any) {
            p := core.ToMapAny(item)
            fmt.Println(p["id"], p["name"])
        }
    }
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```go
result, err := client.Direct(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "GET",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

if result["ok"] == true {
    fmt.Println(result["status"]) // 200
    fmt.Println(result["data"])   // response body
}
```

### Prepare a request without sending it

```go
fetchdef, err := client.Prepare(map[string]any{
    "path":   "/api/resource/{id}",
    "method": "DELETE",
    "params": map[string]any{"id": "example"},
})
if err != nil {
    panic(err)
}

fmt.Println(fetchdef["url"])
fmt.Println(fetchdef["method"])
fmt.Println(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```go
client := sdk.TestSDK(nil, nil)

result, err := client.Planet(nil).Load(
    map[string]any{"id": "test01"}, nil,
)
// result contains mock response data
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```go
mockFetch := func(url string, init map[string]any) (map[string]any, error) {
    return map[string]any{
        "status":     200,
        "statusText": "OK",
        "headers":    map[string]any{},
        "json": (func() any)(func() any {
            return map[string]any{"id": "mock01"}
        }),
    }, nil
}

client := sdk.NewTvmazeSDK(map[string]any{
    "base": "http://localhost:8080",
    "system": map[string]any{
        "fetch": (func(string, map[string]any) (map[string]any, error))(mockFetch),
    },
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
TVMAZE_TEST_LIVE=TRUE
TVMAZE_APIKEY=<your-key>
```

Then run:

```bash
cd go && go test ./test/...
```


## Reference

### NewTvmazeSDK

```go
func NewTvmazeSDK(options map[string]any) *TvmazeSDK
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `"apikey"` | `string` | API key for authentication. |
| `"base"` | `string` | Base URL of the API server. |
| `"prefix"` | `string` | URL path prefix prepended to all requests. |
| `"suffix"` | `string` | URL path suffix appended to all requests. |
| `"feature"` | `map[string]any` | Feature activation flags. |
| `"extend"` | `[]any` | Additional Feature instances to load. |
| `"system"` | `map[string]any` | System overrides (e.g. custom `"fetch"` function). |

### TestSDK

```go
func TestSDK(testopts map[string]any, sdkopts map[string]any) *TvmazeSDK
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### TvmazeSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `OptionsMap` | `() map[string]any` | Deep copy of current SDK options. |
| `GetUtility` | `() *Utility` | Copy of the SDK utility object. |
| `Prepare` | `(fetchargs map[string]any) (map[string]any, error)` | Build an HTTP request definition without sending. |
| `Direct` | `(fetchargs map[string]any) (map[string]any, error)` | Build and send an HTTP request. |
| `Aka` | `(data map[string]any) TvmazeEntity` | Create a Aka entity instance. |
| `AlternateList` | `(data map[string]any) TvmazeEntity` | Create a AlternateList entity instance. |
| `Cast` | `(data map[string]any) TvmazeEntity` | Create a Cast entity instance. |
| `CastCredit` | `(data map[string]any) TvmazeEntity` | Create a CastCredit entity instance. |
| `CastMember` | `(data map[string]any) TvmazeEntity` | Create a CastMember entity instance. |
| `Crew` | `(data map[string]any) TvmazeEntity` | Create a Crew entity instance. |
| `CrewCredit` | `(data map[string]any) TvmazeEntity` | Create a CrewCredit entity instance. |
| `CrewMember` | `(data map[string]any) TvmazeEntity` | Create a CrewMember entity instance. |
| `Episode` | `(data map[string]any) TvmazeEntity` | Create a Episode entity instance. |
| `GuestCastCredit` | `(data map[string]any) TvmazeEntity` | Create a GuestCastCredit entity instance. |
| `Image` | `(data map[string]any) TvmazeEntity` | Create a Image entity instance. |
| `Person` | `(data map[string]any) TvmazeEntity` | Create a Person entity instance. |
| `Schedule` | `(data map[string]any) TvmazeEntity` | Create a Schedule entity instance. |
| `ScheduledEpisode` | `(data map[string]any) TvmazeEntity` | Create a ScheduledEpisode entity instance. |
| `Search` | `(data map[string]any) TvmazeEntity` | Create a Search entity instance. |
| `Season` | `(data map[string]any) TvmazeEntity` | Create a Season entity instance. |
| `Show` | `(data map[string]any) TvmazeEntity` | Create a Show entity instance. |
| `Update` | `(data map[string]any) TvmazeEntity` | Create a Update entity instance. |

### Entity interface (TvmazeEntity)

All entities implement the `TvmazeEntity` interface.

| Method | Signature | Description |
| --- | --- | --- |
| `Load` | `(reqmatch, ctrl map[string]any) (any, error)` | Load a single entity by match criteria. |
| `List` | `(reqmatch, ctrl map[string]any) (any, error)` | List entities matching the criteria. |
| `Create` | `(reqdata, ctrl map[string]any) (any, error)` | Create a new entity. |
| `Update` | `(reqdata, ctrl map[string]any) (any, error)` | Update an existing entity. |
| `Remove` | `(reqmatch, ctrl map[string]any) (any, error)` | Remove an entity. |
| `Data` | `(args ...any) any` | Get or set entity data. |
| `Match` | `(args ...any) any` | Get or set entity match criteria. |
| `Make` | `() Entity` | Create a new instance with the same options. |
| `GetName` | `() string` | Return the entity name. |

### Result shape

Entity operations return `(any, error)`. The `any` value is a
`map[string]any` with these keys:

| Key | Type | Description |
| --- | --- | --- |
| `"ok"` | `bool` | `true` if the HTTP status is 2xx. |
| `"status"` | `int` | HTTP status code. |
| `"headers"` | `map[string]any` | Response headers. |
| `"data"` | `any` | Parsed JSON response body. |

On error, `"ok"` is `false` and `"err"` contains the error value.

### Entities

#### Aka

| Field | Description |
| --- | --- |
| `"country"` |  |
| `"name"` |  |

Operations: List.

API path: `/shows/{id}/akas`

#### AlternateList

| Field | Description |
| --- | --- |
| `"id"` |  |
| `"link"` |  |
| `"name"` |  |
| `"url"` |  |

Operations: List, Load.

API path: `/shows/{id}/alternatelists`

#### Cast

| Field | Description |
| --- | --- |
| `"character"` |  |
| `"person"` |  |
| `"self"` |  |
| `"voice"` |  |

Operations: List.

API path: `/shows/{id}/cast`

#### CastCredit

| Field | Description |
| --- | --- |
| `"link"` |  |

Operations: List.

API path: `/people/{id}/castcredits`

#### CastMember

| Field | Description |
| --- | --- |
| `"character"` |  |
| `"person"` |  |
| `"self"` |  |
| `"voice"` |  |

Operations: List.

API path: `/episodes/{id}/guestcast`

#### Crew

| Field | Description |
| --- | --- |
| `"person"` |  |
| `"type"` |  |

Operations: List.

API path: `/shows/{id}/crew`

#### CrewCredit

| Field | Description |
| --- | --- |
| `"link"` |  |
| `"type"` |  |

Operations: List.

API path: `/people/{id}/crewcredits`

#### CrewMember

| Field | Description |
| --- | --- |
| `"person"` |  |
| `"type"` |  |

Operations: List.

API path: `/episodes/{id}/guestcrew`

#### Episode

| Field | Description |
| --- | --- |
| `"airdate"` |  |
| `"airstamp"` |  |
| `"airtime"` |  |
| `"id"` |  |
| `"image"` |  |
| `"link"` |  |
| `"name"` |  |
| `"number"` |  |
| `"rating"` |  |
| `"runtime"` |  |
| `"season"` |  |
| `"summary"` |  |
| `"type"` |  |
| `"url"` |  |

Operations: List, Load.

API path: `/shows/{id}/episodesbydate`

#### GuestCastCredit

| Field | Description |
| --- | --- |
| `"link"` |  |

Operations: List.

API path: `/people/{id}/guestcastcredits`

#### Image

| Field | Description |
| --- | --- |
| `"id"` |  |
| `"main"` |  |
| `"resolution"` |  |
| `"type"` |  |

Operations: List.

API path: `/shows/{id}/images`

#### Person

| Field | Description |
| --- | --- |
| `"birthday"` |  |
| `"country"` |  |
| `"deathday"` |  |
| `"gender"` |  |
| `"id"` |  |
| `"image"` |  |
| `"link"` |  |
| `"name"` |  |
| `"person"` |  |
| `"score"` |  |
| `"updated"` |  |
| `"url"` |  |

Operations: List, Load.

API path: `/people`

#### Schedule

| Field | Description |
| --- | --- |
| `"airdate"` |  |
| `"airstamp"` |  |
| `"airtime"` |  |
| `"id"` |  |
| `"image"` |  |
| `"link"` |  |
| `"name"` |  |
| `"number"` |  |
| `"rating"` |  |
| `"runtime"` |  |
| `"season"` |  |
| `"show"` |  |
| `"summary"` |  |
| `"type"` |  |
| `"url"` |  |

Operations: List.

API path: `/schedule`

#### ScheduledEpisode

| Field | Description |
| --- | --- |
| `"airdate"` |  |
| `"airstamp"` |  |
| `"airtime"` |  |
| `"id"` |  |
| `"image"` |  |
| `"link"` |  |
| `"name"` |  |
| `"number"` |  |
| `"rating"` |  |
| `"runtime"` |  |
| `"season"` |  |
| `"show"` |  |
| `"summary"` |  |
| `"type"` |  |
| `"url"` |  |

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
| `"end_date"` |  |
| `"episode_order"` |  |
| `"id"` |  |
| `"image"` |  |
| `"link"` |  |
| `"name"` |  |
| `"network"` |  |
| `"number"` |  |
| `"premiere_date"` |  |
| `"summary"` |  |
| `"url"` |  |
| `"web_channel"` |  |

Operations: List.

API path: `/shows/{id}/seasons`

#### Show

| Field | Description |
| --- | --- |
| `"average_runtime"` |  |
| `"dvd_country"` |  |
| `"ended"` |  |
| `"external"` |  |
| `"genre"` |  |
| `"id"` |  |
| `"image"` |  |
| `"language"` |  |
| `"link"` |  |
| `"name"` |  |
| `"network"` |  |
| `"official_site"` |  |
| `"premiered"` |  |
| `"rating"` |  |
| `"runtime"` |  |
| `"schedule"` |  |
| `"score"` |  |
| `"show"` |  |
| `"status"` |  |
| `"summary"` |  |
| `"type"` |  |
| `"updated"` |  |
| `"url"` |  |
| `"web_channel"` |  |
| `"weight"` |  |

Operations: List, Load.

API path: `/alternatelists/{id}/alternateepisodes`

#### Update

| Field | Description |
| --- | --- |

Operations: Load.

API path: `/updates/people`



## Entities


### Aka

Create an instance: `aka := client.Aka(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |

#### Example: List

```go
results, err := client.Aka(nil).List(nil, nil)
```


### AlternateList

Create an instance: `alternate_list := client.AlternateList(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | ``$INTEGER`` |  |
| `link` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `url` | ``$STRING`` |  |

#### Example: Load

```go
result, err := client.AlternateList(nil).Load(map[string]any{"id": "alternate_list_id"}, nil)
```

#### Example: List

```go
results, err := client.AlternateList(nil).List(nil, nil)
```


### Cast

Create an instance: `cast := client.Cast(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `character` | ``$OBJECT`` |  |
| `person` | ``$OBJECT`` |  |
| `self` | ``$BOOLEAN`` |  |
| `voice` | ``$BOOLEAN`` |  |

#### Example: List

```go
results, err := client.Cast(nil).List(nil, nil)
```


### CastCredit

Create an instance: `cast_credit := client.CastCredit(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `link` | ``$OBJECT`` |  |

#### Example: List

```go
results, err := client.CastCredit(nil).List(nil, nil)
```


### CastMember

Create an instance: `cast_member := client.CastMember(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `character` | ``$OBJECT`` |  |
| `person` | ``$OBJECT`` |  |
| `self` | ``$BOOLEAN`` |  |
| `voice` | ``$BOOLEAN`` |  |

#### Example: List

```go
results, err := client.CastMember(nil).List(nil, nil)
```


### Crew

Create an instance: `crew := client.Crew(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `person` | ``$OBJECT`` |  |
| `type` | ``$STRING`` |  |

#### Example: List

```go
results, err := client.Crew(nil).List(nil, nil)
```


### CrewCredit

Create an instance: `crew_credit := client.CrewCredit(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `link` | ``$OBJECT`` |  |
| `type` | ``$STRING`` |  |

#### Example: List

```go
results, err := client.CrewCredit(nil).List(nil, nil)
```


### CrewMember

Create an instance: `crew_member := client.CrewMember(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `person` | ``$OBJECT`` |  |
| `type` | ``$STRING`` |  |

#### Example: List

```go
results, err := client.CrewMember(nil).List(nil, nil)
```


### Episode

Create an instance: `episode := client.Episode(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `airdate` | ``$STRING`` |  |
| `airstamp` | ``$STRING`` |  |
| `airtime` | ``$STRING`` |  |
| `id` | ``$INTEGER`` |  |
| `image` | ``$OBJECT`` |  |
| `link` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `number` | ``$INTEGER`` |  |
| `rating` | ``$OBJECT`` |  |
| `runtime` | ``$INTEGER`` |  |
| `season` | ``$INTEGER`` |  |
| `summary` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |
| `url` | ``$STRING`` |  |

#### Example: Load

```go
result, err := client.Episode(nil).Load(map[string]any{"id": "episode_id"}, nil)
```

#### Example: List

```go
results, err := client.Episode(nil).List(nil, nil)
```


### GuestCastCredit

Create an instance: `guest_cast_credit := client.GuestCastCredit(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `link` | ``$OBJECT`` |  |

#### Example: List

```go
results, err := client.GuestCastCredit(nil).List(nil, nil)
```


### Image

Create an instance: `image := client.Image(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | ``$INTEGER`` |  |
| `main` | ``$BOOLEAN`` |  |
| `resolution` | ``$OBJECT`` |  |
| `type` | ``$STRING`` |  |

#### Example: List

```go
results, err := client.Image(nil).List(nil, nil)
```


### Person

Create an instance: `person := client.Person(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday` | ``$STRING`` |  |
| `country` | ``$OBJECT`` |  |
| `deathday` | ``$STRING`` |  |
| `gender` | ``$STRING`` |  |
| `id` | ``$INTEGER`` |  |
| `image` | ``$OBJECT`` |  |
| `link` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `person` | ``$OBJECT`` |  |
| `score` | ``$NUMBER`` |  |
| `updated` | ``$INTEGER`` |  |
| `url` | ``$STRING`` |  |

#### Example: Load

```go
result, err := client.Person(nil).Load(map[string]any{"id": "person_id"}, nil)
```

#### Example: List

```go
results, err := client.Person(nil).List(nil, nil)
```


### Schedule

Create an instance: `schedule := client.Schedule(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `airdate` | ``$STRING`` |  |
| `airstamp` | ``$STRING`` |  |
| `airtime` | ``$STRING`` |  |
| `id` | ``$INTEGER`` |  |
| `image` | ``$OBJECT`` |  |
| `link` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `number` | ``$INTEGER`` |  |
| `rating` | ``$OBJECT`` |  |
| `runtime` | ``$INTEGER`` |  |
| `season` | ``$INTEGER`` |  |
| `show` | ``$OBJECT`` |  |
| `summary` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |
| `url` | ``$STRING`` |  |

#### Example: List

```go
results, err := client.Schedule(nil).List(nil, nil)
```


### ScheduledEpisode

Create an instance: `scheduled_episode := client.ScheduledEpisode(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `airdate` | ``$STRING`` |  |
| `airstamp` | ``$STRING`` |  |
| `airtime` | ``$STRING`` |  |
| `id` | ``$INTEGER`` |  |
| `image` | ``$OBJECT`` |  |
| `link` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `number` | ``$INTEGER`` |  |
| `rating` | ``$OBJECT`` |  |
| `runtime` | ``$INTEGER`` |  |
| `season` | ``$INTEGER`` |  |
| `show` | ``$OBJECT`` |  |
| `summary` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |
| `url` | ``$STRING`` |  |

#### Example: List

```go
results, err := client.ScheduledEpisode(nil).List(nil, nil)
```


### Search

Create an instance: `search := client.Search(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```go
result, err := client.Search(nil).Load(map[string]any{"id": "search_id"}, nil)
```


### Season

Create an instance: `season := client.Season(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `end_date` | ``$STRING`` |  |
| `episode_order` | ``$INTEGER`` |  |
| `id` | ``$INTEGER`` |  |
| `image` | ``$OBJECT`` |  |
| `link` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `network` | ``$OBJECT`` |  |
| `number` | ``$INTEGER`` |  |
| `premiere_date` | ``$STRING`` |  |
| `summary` | ``$STRING`` |  |
| `url` | ``$STRING`` |  |
| `web_channel` | ``$OBJECT`` |  |

#### Example: List

```go
results, err := client.Season(nil).List(nil, nil)
```


### Show

Create an instance: `show := client.Show(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `List(match, ctrl)` | List entities matching the criteria. |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `average_runtime` | ``$INTEGER`` |  |
| `dvd_country` | ``$OBJECT`` |  |
| `ended` | ``$STRING`` |  |
| `external` | ``$OBJECT`` |  |
| `genre` | ``$ARRAY`` |  |
| `id` | ``$INTEGER`` |  |
| `image` | ``$OBJECT`` |  |
| `language` | ``$STRING`` |  |
| `link` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `network` | ``$OBJECT`` |  |
| `official_site` | ``$STRING`` |  |
| `premiered` | ``$STRING`` |  |
| `rating` | ``$OBJECT`` |  |
| `runtime` | ``$INTEGER`` |  |
| `schedule` | ``$OBJECT`` |  |
| `score` | ``$NUMBER`` |  |
| `show` | ``$OBJECT`` |  |
| `status` | ``$STRING`` |  |
| `summary` | ``$STRING`` |  |
| `type` | ``$STRING`` |  |
| `updated` | ``$INTEGER`` |  |
| `url` | ``$STRING`` |  |
| `web_channel` | ``$OBJECT`` |  |
| `weight` | ``$INTEGER`` |  |

#### Example: Load

```go
result, err := client.Show(nil).Load(map[string]any{"id": "show_id"}, nil)
```

#### Example: List

```go
results, err := client.Show(nil).List(nil, nil)
```


### Update

Create an instance: `update := client.Update(nil)`

#### Operations

| Method | Description |
| --- | --- |
| `Load(match, ctrl)` | Load a single entity by match criteria. |

#### Example: Load

```go
result, err := client.Update(nil).Load(map[string]any{"id": "update_id"}, nil)
```


## Explanation

### The operation pipeline

Every entity operation (load, list, create, update, remove) follows a
six-stage pipeline. Each stage fires a feature hook before executing:

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

If any stage returns an error, the pipeline short-circuits and the
error is returned to the caller. An unexpected panic triggers the
`PreUnexpected` hook.

### Features and hooks

Features are the extension mechanism. A feature implements the
`Feature` interface and provides hooks — functions keyed by pipeline
stage names.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as maps

The Go SDK uses `map[string]any` throughout rather than typed structs.
This mirrors the dynamic nature of the API and keeps the SDK
flexible — no code generation is needed when the API schema changes.

Use `core.ToMapAny()` to safely cast results and nested data.

### Package structure

```
github.com/voxgig-sdk/tvmaze-sdk/
├── tvmaze.go        # Root package — type aliases and constructors
├── core/               # SDK core — client, types, pipeline
├── entity/             # Entity implementations
├── feature/            # Built-in features (Base, Test, Log)
├── utility/            # Utility functions and struct library
└── test/               # Test suites
```

The root package (`github.com/voxgig-sdk/tvmaze-sdk`) re-exports everything needed
for normal use. Import sub-packages only when you need specific types
like `core.ToMapAny`.

### Entity state

Entity instances are stateful. After a successful `Load`, the entity
stores the returned data and match criteria internally.

```go
moon := client.Moon(nil)
moon.Load(map[string]any{"planet_id": "earth", "id": "luna"}, nil)

// moon.Data() now returns the loaded moon data
// moon.Match() returns the last match criteria
```

Call `Make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`Direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `Prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
