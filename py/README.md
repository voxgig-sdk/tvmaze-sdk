# Tvmaze Python SDK



The Python SDK for the Tvmaze API — an entity-oriented client following Pythonic conventions.

The SDK exposes the API as capitalised, semantic **Entities** — for example `client.Aka()` — each
carrying a small, uniform set of operations (`list`, `load`) instead of raw URL
paths and query strings. You work with named resources and verbs, which
keeps the cognitive load low.

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
    akas = client.Aka().list({"show_id": 1})
    for aka in akas:
        print(aka)
except Exception as err:
    print(f"list failed: {err}")
```


## Error handling

Entity operations raise on failure, so wrap them in `try` / `except`:

```python
try:
    images = client.Image().list()
    print(images)
except Exception as err:
    print(f"list failed: {err}")
```

`direct()` does **not** raise — it returns the result envelope. Branch
on `ok`; on failure `status` holds the HTTP status (for error responses)
and `err` holds a transport error, so read both defensively:

```python
result = client.direct({
    "path": "/api/resource/{id}",
    "method": "GET",
    "params": {"id": "example_id"},
})

if not result["ok"]:
    print("request failed:", result.get("status"), result.get("err"))
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
    # A non-2xx response carries status + data (the error body); a
    # transport-level failure carries err instead. Only one is present, so
    # read both with .get() rather than indexing a key that may be absent.
    print(result.get("status"), result.get("err"))
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

# Entity ops return the ENTITY and raises on error;
# call data_get() for the record.
image = client.Image().list()
# image contains the mock response record
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
| `data_get` | `() -> dict` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> dict` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> str` | Return the entity name. |

### Result shape

Entity operations return the ENTITY (call data_get() for the record) (a `dict` for single-entity
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

Create an instance: `aka = client.Aka()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country` | `dict` |  |
| `name` | `str` | Alternate name |

#### Example: List

```python
akas = client.Aka().list({"show_id": 1})
```


### AlternateList

Create an instance: `alternate_list = client.AlternateList()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `int` | Unique alternate list identifier |
| `links` | `dict` |  |
| `name` | `str` | Name of alternate list (e.g., DVD Order) |
| `self` | `dict` |  |
| `url` | `str` | TVmaze URL for the alternate list |

#### Example: Load

```python
alternate_list = client.AlternateList().load({"id": 1})
```

#### Example: List

```python
alternate_lists = client.AlternateList().list({"show_id": 1})
```


### Cast

Create an instance: `cast = client.Cast()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `character` | `dict` |  |
| `person` | `dict` |  |
| `self` | `bool` | Whether person plays themselves |
| `voice` | `bool` | Whether this is a voice role |

#### Example: List

```python
casts = client.Cast().list({"show_id": 1})
```


### CastCredit

Create an instance: `cast_credit = client.CastCredit()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `links` | `dict` |  |

#### Example: List

```python
cast_credits = client.CastCredit().list({"person_id": 1})
```


### CastMember

Create an instance: `cast_member = client.CastMember()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `character` | `dict` |  |
| `person` | `dict` |  |
| `self` | `bool` | Whether person plays themselves |
| `voice` | `bool` | Whether this is a voice role |

#### Example: List

```python
cast_members = client.CastMember().list({"episode_id": 1})
```


### Crew

Create an instance: `crew = client.Crew()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `person` | `dict` |  |
| `type` | `str` | Crew type (e.g., Executive Producer) |

#### Example: List

```python
crews = client.Crew().list({"show_id": 1})
```


### CrewCredit

Create an instance: `crew_credit = client.CrewCredit()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `links` | `dict` |  |
| `type` | `str` | Crew type |

#### Example: List

```python
crew_credits = client.CrewCredit().list({"person_id": 1})
```


### CrewMember

Create an instance: `crew_member = client.CrewMember()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `person` | `dict` |  |
| `type` | `str` | Crew type (e.g., Executive Producer) |

#### Example: List

```python
crew_members = client.CrewMember().list({"episode_id": 1})
```


### Episode

Create an instance: `episode = client.Episode()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `airdate` | `str` | Air date |
| `airstamp` | `str` | Air timestamp |
| `airtime` | `str` | Air time |
| `id` | `int` | Unique episode identifier |
| `image` | `dict` |  |
| `links` | `dict` |  |
| `name` | `str` | Episode name |
| `number` | `int` | Episode number in season |
| `rating` | `dict` |  |
| `runtime` | `int` | Runtime in minutes |
| `season` | `int` | Season number |
| `summary` | `str` | HTML summary |
| `type` | `str` | Episode type (e.g., regular, significant_special) |
| `url` | `str` | TVmaze URL for the episode |

#### Example: Load

```python
episode = client.Episode().load({"id": 1})
```

#### Example: List

```python
episodes = client.Episode().list({"show_id": 1, "date": "example"})
```


### GuestCastCredit

Create an instance: `guest_cast_credit = client.GuestCastCredit()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `links` | `dict` |  |

#### Example: List

```python
guest_cast_credits = client.GuestCastCredit().list({"person_id": 1})
```


### Image

Create an instance: `image = client.Image()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `int` | Unique image identifier |
| `main` | `bool` | Whether this is the main image |
| `resolutions` | `dict` |  |
| `type` | `str` | Image type |

#### Example: List

```python
images = client.Image().list({"show_id": 1})
```


### Person

Create an instance: `person = client.Person()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday` | `str` | Birth date |
| `country` | `dict` |  |
| `deathday` | `str` | Death date |
| `gender` | `str` | Gender |
| `id` | `int` | Unique person identifier |
| `image` | `dict` |  |
| `links` | `dict` |  |
| `name` | `str` | Person name |
| `person` | `dict` |  |
| `score` | `float` | Search relevancy score |
| `updated` | `int` | Unix timestamp of last update |
| `url` | `str` | TVmaze URL for the person |

#### Example: Load

```python
person = client.Person().load({"id": 1})
```

#### Example: List

```python
persons = client.Person().list()
```


### Schedule

Create an instance: `schedule = client.Schedule()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `airdate` | `str` | Air date |
| `airstamp` | `str` | Air timestamp |
| `airtime` | `str` | Air time |
| `id` | `int` | Unique episode identifier |
| `image` | `dict` |  |
| `links` | `dict` |  |
| `name` | `str` | Episode name |
| `number` | `int` | Episode number in season |
| `rating` | `dict` |  |
| `runtime` | `int` | Runtime in minutes |
| `season` | `int` | Season number |
| `show` | `dict` |  |
| `summary` | `str` | HTML summary |
| `type` | `str` | Episode type (e.g., regular, significant_special) |
| `url` | `str` | TVmaze URL for the episode |

#### Example: List

```python
schedules = client.Schedule().list()
```


### ScheduledEpisode

Create an instance: `scheduled_episode = client.ScheduledEpisode()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `airdate` | `str` | Air date |
| `airstamp` | `str` | Air timestamp |
| `airtime` | `str` | Air time |
| `id` | `int` | Unique episode identifier |
| `image` | `dict` |  |
| `links` | `dict` |  |
| `name` | `str` | Episode name |
| `number` | `int` | Episode number in season |
| `rating` | `dict` |  |
| `runtime` | `int` | Runtime in minutes |
| `season` | `int` | Season number |
| `show` | `dict` |  |
| `summary` | `str` | HTML summary |
| `type` | `str` | Episode type (e.g., regular, significant_special) |
| `url` | `str` | TVmaze URL for the episode |

#### Example: List

```python
scheduled_episodes = client.ScheduledEpisode().list()
```


### Search

Create an instance: `search = client.Search()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```python
search = client.Search().load()
```


### Season

Create an instance: `season = client.Season()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `endDate` | `str` | End date |
| `episodeOrder` | `int` | Number of episodes |
| `id` | `int` | Unique season identifier |
| `image` | `dict` |  |
| `links` | `dict` |  |
| `name` | `str` | Season name |
| `network` | `dict` |  |
| `number` | `int` | Season number |
| `premiereDate` | `str` | Premiere date |
| `summary` | `str` | HTML summary |
| `url` | `str` | TVmaze URL for the season |
| `webChannel` | `dict` |  |

#### Example: List

```python
seasons = client.Season().list({"show_id": 1})
```


### Show

Create an instance: `show = client.Show()`

#### Operations

| Method | Description |
| --- | --- |
| `list()` | List entities, optionally matching the given criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `averageRuntime` | `int` | Average runtime in minutes |
| `dvdCountry` | `dict` |  |
| `ended` | `str` | End date |
| `externals` | `dict` |  |
| `genres` | `list` | List of genres |
| `id` | `int` | Unique show identifier |
| `image` | `dict` |  |
| `language` | `str` | Original language |
| `links` | `dict` |  |
| `name` | `str` | Show name |
| `network` | `dict` |  |
| `officialSite` | `str` | Official website URL |
| `premiered` | `str` | Premiere date |
| `rating` | `dict` |  |
| `runtime` | `int` | Runtime in minutes |
| `schedule` | `dict` |  |
| `score` | `float` | Search relevancy score |
| `show` | `dict` |  |
| `status` | `str` | Current status (e.g., Running, Ended) |
| `summary` | `str` | HTML summary |
| `type` | `str` | Show type (e.g., Scripted, Reality) |
| `updated` | `int` | Unix timestamp of last update |
| `url` | `str` | TVmaze URL for the show |
| `webChannel` | `dict` |  |
| `weight` | `int` | Show weight/importance |

#### Example: Load

```python
show = client.Show().load({"id": 1})
```

#### Example: List

```python
shows = client.Show().list()
```


### Update

Create an instance: `update = client.Update()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```python
update = client.Update().load()
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

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally.

```python
image = client.Image()
image.list()

# image.data_get() now returns the image data from the last list
# image.match_get() returns the last match criteria
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
