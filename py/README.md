# Tvmaze Python SDK



The Python SDK for the Tvmaze API — an entity-oriented client following Pythonic conventions.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to PyPI. Install it from the GitHub
release tag (`py/vX.Y.Z`, see [Releases](https://github.com/voxgig-sdk/tvmaze-sdk/releases)) or
from a source checkout:

```bash
pip install -e .
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```python
from tvmaze_sdk import TvmazeSDK

client = TvmazeSDK()
```

### 2. List aka records

`list()` returns a `list` of records (each a `dict`) and raises on
error — iterate it directly.

```python
try:
    akas = client.Aka().list({})
    for aka in akas:
        print(aka)
except Exception as err:
    print(f"list failed: {err}")
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```python
result = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example"},
})

if result["ok"]:
    print(result["status"])  # 200
    print(result["data"])    # response body
else:
    print(result["err"])     # error value
```

### Prepare a request without sending it

```python
# prepare() returns the fetch definition and raises on error.
fetchdef = client.prepare({
    "path": "/api/resource/{id}",
    "method": "DELETE",
    "params": {"id": "example"},
})

print(fetchdef["url"])
print(fetchdef["method"])
print(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```python
client = TvmazeSDK.test()

# Entity ops return the bare record and raise on error.
aka = client.Aka().load({"id": "test01"})
# aka contains the mock response record
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```python
def mock_fetch(url, init):
    return {
        "status": 200,
        "statusText": "OK",
        "headers": {},
        "json": lambda: {"id": "mock01"},
    }, None

client = TvmazeSDK({
    "base": "http://localhost:8080",
    "system": {
        "fetch": mock_fetch,
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
cd py && pytest test/
```


## Reference

### TvmazeSDK

```python
from tvmaze_sdk import TvmazeSDK

client = TvmazeSDK(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `base` | `str` | Base URL of the API server. |
| `prefix` | `str` | URL path prefix prepended to all requests. |
| `suffix` | `str` | URL path suffix appended to all requests. |
| `feature` | `dict` | Feature activation flags. |
| `extend` | `list` | Additional Feature instances to load. |
| `system` | `dict` | System overrides (e.g. custom `fetch` function). |

### test

```python
client = TvmazeSDK.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `None`.

### TvmazeSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> dict` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> dict` | Build an HTTP request definition without sending. Raises on error. |
| `direct` | `(fetchargs) -> dict` | Build and send an HTTP request. Returns a result dict (branch on `ok`). |
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
| `list` | `(reqmatch, ctrl) -> list` | List entities matching the criteria. Raises on error. |
| `create` | `(reqdata, ctrl) -> any` | Create a new entity. Raises on error. |
| `update` | `(reqdata, ctrl) -> any` | Update an existing entity. Raises on error. |
| `remove` | `(reqmatch, ctrl) -> any` | Remove an entity. Raises on error. |
| `data_get` | `() -> dict` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> dict` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> str` | Return the entity name. |

### Result shape

Entity operations return the bare result data (a `dict` for single-entity
ops, a `list` for `list`) and raise on error. Wrap calls in
`try`/`except` to handle failures.

The `direct()` escape hatch never raises — it returns a result `dict`
you branch on via `result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `True` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `dict` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `False` and `err` contains the error value.

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

Create an instance: `aka = client.Aka()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |

#### Example: List

```python
akas = client.Aka().list({})
```


### AlternateList

Create an instance: `alternate_list = client.AlternateList()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | ``$INTEGER`` |  |
| `link` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `url` | ``$STRING`` |  |

#### Example: Load

```python
alternate_list = client.AlternateList().load({"id": "alternate_list_id"})
```

#### Example: List

```python
alternate_lists = client.AlternateList().list({})
```


### Cast

Create an instance: `cast = client.Cast()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `character` | ``$OBJECT`` |  |
| `person` | ``$OBJECT`` |  |
| `self` | ``$BOOLEAN`` |  |
| `voice` | ``$BOOLEAN`` |  |

#### Example: List

```python
casts = client.Cast().list({})
```


### CastCredit

Create an instance: `cast_credit = client.CastCredit()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `link` | ``$OBJECT`` |  |

#### Example: List

```python
cast_credits = client.CastCredit().list({})
```


### CastMember

Create an instance: `cast_member = client.CastMember()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `character` | ``$OBJECT`` |  |
| `person` | ``$OBJECT`` |  |
| `self` | ``$BOOLEAN`` |  |
| `voice` | ``$BOOLEAN`` |  |

#### Example: List

```python
cast_members = client.CastMember().list({})
```


### Crew

Create an instance: `crew = client.Crew()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `person` | ``$OBJECT`` |  |
| `type` | ``$STRING`` |  |

#### Example: List

```python
crews = client.Crew().list({})
```


### CrewCredit

Create an instance: `crew_credit = client.CrewCredit()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `link` | ``$OBJECT`` |  |
| `type` | ``$STRING`` |  |

#### Example: List

```python
crew_credits = client.CrewCredit().list({})
```


### CrewMember

Create an instance: `crew_member = client.CrewMember()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `person` | ``$OBJECT`` |  |
| `type` | ``$STRING`` |  |

#### Example: List

```python
crew_members = client.CrewMember().list({})
```


### Episode

Create an instance: `episode = client.Episode()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

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

```python
episode = client.Episode().load({"id": "episode_id"})
```

#### Example: List

```python
episodes = client.Episode().list({})
```


### GuestCastCredit

Create an instance: `guest_cast_credit = client.GuestCastCredit()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `link` | ``$OBJECT`` |  |

#### Example: List

```python
guest_cast_credits = client.GuestCastCredit().list({})
```


### Image

Create an instance: `image = client.Image()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | ``$INTEGER`` |  |
| `main` | ``$BOOLEAN`` |  |
| `resolution` | ``$OBJECT`` |  |
| `type` | ``$STRING`` |  |

#### Example: List

```python
images = client.Image().list({})
```


### Person

Create an instance: `person = client.Person()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

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

```python
person = client.Person().load({"id": "person_id"})
```

#### Example: List

```python
persons = client.Person().list({})
```


### Schedule

Create an instance: `schedule = client.Schedule()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

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

```python
schedules = client.Schedule().list({})
```


### ScheduledEpisode

Create an instance: `scheduled_episode = client.ScheduledEpisode()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

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

```python
scheduled_episodes = client.ScheduledEpisode().list({})
```


### Search

Create an instance: `search = client.Search()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```python
search = client.Search().load({"id": "search_id"})
```


### Season

Create an instance: `season = client.Season()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

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

```python
seasons = client.Season().list({})
```


### Show

Create an instance: `show = client.Show()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

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

```python
show = client.Show().load({"id": "show_id"})
```

#### Example: List

```python
shows = client.Show().list({})
```


### Update

Create an instance: `update = client.Update()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```python
update = client.Update().load({"id": "update_id"})
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
error is returned to the caller as the second element in the return tuple.

### Features and hooks

Features are the extension mechanism. A feature is a Python class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as dicts

The Python SDK uses plain dicts throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `helpers.to_map()` to safely validate that a value is a dict.

### Module structure

```
py/
├── tvmaze_sdk.py         -- Main SDK module
├── config.py                    -- Configuration
├── features.py                  -- Feature factory
├── core/                        -- Core types and context
├── entity/                      -- Entity implementations
├── feature/                     -- Built-in features (Base, Test, Log)
├── utility/                     -- Utility functions and struct library
└── test/                        -- Test suites
```

The main module (`tvmaze_sdk`) exports the SDK class.
Import entity or utility modules directly only when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally.

```python
aka = client.Aka()
aka.load({"id": "example_id"})

# aka.data_get() now returns the loaded aka data
# aka.match_get() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

`direct()` gives full control over the HTTP request. Use it for
non-standard endpoints, bulk operations, or any path not modelled as
an entity. `prepare()` builds the request without sending it — useful
for debugging or custom transport.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
