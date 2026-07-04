# Tvmaze Python SDK Reference

Complete API reference for the Tvmaze Python SDK.


## TvmazeSDK

### Constructor

```python
from tvmaze_sdk import TvmazeSDK

client = TvmazeSDK(options)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `dict` | SDK configuration options. |
| `options["base"]` | `str` | Base URL for API requests. |
| `options["prefix"]` | `str` | URL prefix appended after base. |
| `options["suffix"]` | `str` | URL suffix appended after path. |
| `options["headers"]` | `dict` | Custom headers for all requests. |
| `options["feature"]` | `dict` | Feature configuration. |
| `options["system"]` | `dict` | System overrides (e.g. custom fetch). |


### Static Methods

#### `TvmazeSDK.test(testopts=None, sdkopts=None)`

Create a test client with mock features active. Both arguments may be `None`.

```python
client = TvmazeSDK.test()
```


### Instance Methods

#### `Aka(data=None)`

Create a new `AkaEntity` instance. Pass `None` for no initial data.

#### `AlternateList(data=None)`

Create a new `AlternateListEntity` instance. Pass `None` for no initial data.

#### `Cast(data=None)`

Create a new `CastEntity` instance. Pass `None` for no initial data.

#### `CastCredit(data=None)`

Create a new `CastCreditEntity` instance. Pass `None` for no initial data.

#### `CastMember(data=None)`

Create a new `CastMemberEntity` instance. Pass `None` for no initial data.

#### `Crew(data=None)`

Create a new `CrewEntity` instance. Pass `None` for no initial data.

#### `CrewCredit(data=None)`

Create a new `CrewCreditEntity` instance. Pass `None` for no initial data.

#### `CrewMember(data=None)`

Create a new `CrewMemberEntity` instance. Pass `None` for no initial data.

#### `Episode(data=None)`

Create a new `EpisodeEntity` instance. Pass `None` for no initial data.

#### `GuestCastCredit(data=None)`

Create a new `GuestCastCreditEntity` instance. Pass `None` for no initial data.

#### `Image(data=None)`

Create a new `ImageEntity` instance. Pass `None` for no initial data.

#### `Person(data=None)`

Create a new `PersonEntity` instance. Pass `None` for no initial data.

#### `Schedule(data=None)`

Create a new `ScheduleEntity` instance. Pass `None` for no initial data.

#### `ScheduledEpisode(data=None)`

Create a new `ScheduledEpisodeEntity` instance. Pass `None` for no initial data.

#### `Search(data=None)`

Create a new `SearchEntity` instance. Pass `None` for no initial data.

#### `Season(data=None)`

Create a new `SeasonEntity` instance. Pass `None` for no initial data.

#### `Show(data=None)`

Create a new `ShowEntity` instance. Pass `None` for no initial data.

#### `Update(data=None)`

Create a new `UpdateEntity` instance. Pass `None` for no initial data.

#### `options_map() -> dict`

Return a deep copy of the current SDK options.

#### `get_utility() -> Utility`

Return a copy of the SDK utility object.

#### `direct(fetchargs=None) -> dict`

Make a direct HTTP request to any API endpoint. Returns a result `dict` with `ok`, `status`, `headers`, and `data` (or `err` on failure). This escape hatch never raises — branch on `result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs["path"]` | `str` | URL path with optional `{param}` placeholders. |
| `fetchargs["method"]` | `str` | HTTP method (default: `"GET"`). |
| `fetchargs["params"]` | `dict` | Path parameter values. |
| `fetchargs["query"]` | `dict` | Query string parameters. |
| `fetchargs["headers"]` | `dict` | Request headers (merged with defaults). |
| `fetchargs["body"]` | `any` | Request body (dicts are JSON-serialized). |

**Returns:** `result_dict`

#### `prepare(fetchargs=None) -> dict`

Prepare a fetch definition without sending. Returns the `fetchdef` and raises on error.


---

## AkaEntity

```python
aka = client.aka
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.aka.list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `AkaEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## AlternateListEntity

```python
alternate_list = client.alternate_list
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | ``$INTEGER`` | No |  |
| `link` | ``$OBJECT`` | No |  |
| `name` | ``$STRING`` | No |  |
| `url` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.alternate_list.list({})
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.alternate_list.load({"id": "alternate_list_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `AlternateListEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## CastEntity

```python
cast = client.cast
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `character` | ``$OBJECT`` | No |  |
| `person` | ``$OBJECT`` | No |  |
| `self` | ``$BOOLEAN`` | No |  |
| `voice` | ``$BOOLEAN`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.cast.list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CastEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## CastCreditEntity

```python
cast_credit = client.cast_credit
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | ``$OBJECT`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.cast_credit.list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CastCreditEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## CastMemberEntity

```python
cast_member = client.cast_member
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `character` | ``$OBJECT`` | No |  |
| `person` | ``$OBJECT`` | No |  |
| `self` | ``$BOOLEAN`` | No |  |
| `voice` | ``$BOOLEAN`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.cast_member.list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CastMemberEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## CrewEntity

```python
crew = client.crew
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `person` | ``$OBJECT`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.crew.list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CrewEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## CrewCreditEntity

```python
crew_credit = client.crew_credit
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | ``$OBJECT`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.crew_credit.list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CrewCreditEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## CrewMemberEntity

```python
crew_member = client.crew_member
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `person` | ``$OBJECT`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.crew_member.list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `CrewMemberEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## EpisodeEntity

```python
episode = client.episode
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

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.episode.list({})
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.episode.load({"id": "episode_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `EpisodeEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## GuestCastCreditEntity

```python
guest_cast_credit = client.guest_cast_credit
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | ``$OBJECT`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.guest_cast_credit.list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `GuestCastCreditEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ImageEntity

```python
image = client.image
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | ``$INTEGER`` | No |  |
| `main` | ``$BOOLEAN`` | No |  |
| `resolution` | ``$OBJECT`` | No |  |
| `type` | ``$STRING`` | No |  |

### Operations

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.image.list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ImageEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## PersonEntity

```python
person = client.person
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

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.person.list({})
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.person.load({"id": "person_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `PersonEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ScheduleEntity

```python
schedule = client.schedule
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

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.schedule.list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ScheduleEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ScheduledEpisodeEntity

```python
scheduled_episode = client.scheduled_episode
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

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.scheduled_episode.list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ScheduledEpisodeEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## SearchEntity

```python
search = client.search
```

### Operations

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.search.load({"id": "search_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SearchEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## SeasonEntity

```python
season = client.season
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

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.season.list({})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `SeasonEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## ShowEntity

```python
show = client.show
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

#### `list(reqmatch, ctrl=None) -> list`

List entities matching the given criteria. Returns a list and raises on error.

```python
results = client.show.list({})
```

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.show.load({"id": "show_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `ShowEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## UpdateEntity

```python
update = client.update
```

### Operations

#### `load(reqmatch, ctrl=None) -> dict`

Load a single entity matching the given criteria. Returns the entity data and raises on error.

```python
result = client.update.load({"id": "update_id"})
```

### Common Methods

#### `data_get() -> dict`

Get the entity data.

#### `data_set(data)`

Set the entity data.

#### `match_get() -> dict`

Get the entity match criteria.

#### `match_set(match)`

Set the entity match criteria.

#### `make() -> Entity`

Create a new `UpdateEntity` instance with the same options.

#### `get_name() -> str`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```python
client = TvmazeSDK({
    "feature": {
        "test": {"active": True},
    },
})
```

