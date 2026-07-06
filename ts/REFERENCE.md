# Tvmaze TypeScript SDK Reference

Complete API reference for the Tvmaze TypeScript SDK.


## TvmazeSDK

### Constructor

```ts
new TvmazeSDK(options?: object)
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `options` | `object` | SDK configuration options. |
| `options.base` | `string` | Base URL for API requests. |
| `options.prefix` | `string` | URL prefix appended after base. |
| `options.suffix` | `string` | URL suffix appended after path. |
| `options.headers` | `object` | Custom headers for all requests. |
| `options.feature` | `object` | Feature configuration. |
| `options.system` | `object` | System overrides (e.g. custom fetch). |


### Static Methods

#### `TvmazeSDK.test(testopts?, sdkopts?)`

Create a test client with mock features active.

```ts
const client = TvmazeSDK.test()
```

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `testopts` | `object` | Test feature options. |
| `sdkopts` | `object` | Additional SDK options merged with test defaults. |

**Returns:** `TvmazeSDK` instance in test mode.


### Instance Methods

#### `Aka(data?: object)`

Create a new `Aka` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `AkaEntity` instance.

#### `AlternateList(data?: object)`

Create a new `AlternateList` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `AlternateListEntity` instance.

#### `Cast(data?: object)`

Create a new `Cast` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `CastEntity` instance.

#### `CastCredit(data?: object)`

Create a new `CastCredit` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `CastCreditEntity` instance.

#### `CastMember(data?: object)`

Create a new `CastMember` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `CastMemberEntity` instance.

#### `Crew(data?: object)`

Create a new `Crew` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `CrewEntity` instance.

#### `CrewCredit(data?: object)`

Create a new `CrewCredit` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `CrewCreditEntity` instance.

#### `CrewMember(data?: object)`

Create a new `CrewMember` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `CrewMemberEntity` instance.

#### `Episode(data?: object)`

Create a new `Episode` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `EpisodeEntity` instance.

#### `GuestCastCredit(data?: object)`

Create a new `GuestCastCredit` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `GuestCastCreditEntity` instance.

#### `Image(data?: object)`

Create a new `Image` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ImageEntity` instance.

#### `Person(data?: object)`

Create a new `Person` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `PersonEntity` instance.

#### `Schedule(data?: object)`

Create a new `Schedule` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ScheduleEntity` instance.

#### `ScheduledEpisode(data?: object)`

Create a new `ScheduledEpisode` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ScheduledEpisodeEntity` instance.

#### `Search(data?: object)`

Create a new `Search` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `SearchEntity` instance.

#### `Season(data?: object)`

Create a new `Season` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `SeasonEntity` instance.

#### `Show(data?: object)`

Create a new `Show` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `ShowEntity` instance.

#### `Update(data?: object)`

Create a new `Update` entity instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `data` | `object` | Initial entity data. |

**Returns:** `UpdateEntity` instance.

#### `options()`

Return a deep copy of the current SDK options.

**Returns:** `object`

#### `utility()`

Return a copy of the SDK utility object.

**Returns:** `object`

#### `direct(fetchargs?: object)`

Make a direct HTTP request to any API endpoint.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `fetchargs.path` | `string` | URL path with optional `{param}` placeholders. |
| `fetchargs.method` | `string` | HTTP method (default: `GET`). |
| `fetchargs.params` | `object` | Path parameter values for `{param}` substitution. |
| `fetchargs.query` | `object` | Query string parameters. |
| `fetchargs.headers` | `object` | Request headers (merged with defaults). |
| `fetchargs.body` | `any` | Request body (objects are JSON-serialized). |
| `fetchargs.ctrl` | `object` | Control options (e.g. `{ explain: true }`). |

**Returns:** `Promise<{ ok, status, headers, data } | Error>`

#### `prepare(fetchargs?: object)`

Prepare a fetch definition without sending the request. Accepts the
same parameters as `direct()`.

**Returns:** `Promise<{ url, method, headers, body } | Error>`

#### `tester(testopts?, sdkopts?)`

Alias for `TvmazeSDK.test()`.

**Returns:** `TvmazeSDK` instance in test mode.


---

## AkaEntity

```ts
const aka = client.Aka()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country` | `Record<string, any>` | No |  |
| `name` | `string` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Aka().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `AkaEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## AlternateListEntity

```ts
const alternate_list = client.AlternateList()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `number` | No |  |
| `link` | `Record<string, any>` | No |  |
| `name` | `string` | No |  |
| `url` | `string` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.AlternateList().list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.AlternateList().load({ id: 1 })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `AlternateListEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## CastEntity

```ts
const cast = client.Cast()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `character` | `Record<string, any>` | No |  |
| `person` | `Record<string, any>` | No |  |
| `self` | `boolean` | No |  |
| `voice` | `boolean` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Cast().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `CastEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## CastCreditEntity

```ts
const cast_credit = client.CastCredit()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | `Record<string, any>` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.CastCredit().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `CastCreditEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## CastMemberEntity

```ts
const cast_member = client.CastMember()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `character` | `Record<string, any>` | No |  |
| `person` | `Record<string, any>` | No |  |
| `self` | `boolean` | No |  |
| `voice` | `boolean` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.CastMember().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `CastMemberEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## CrewEntity

```ts
const crew = client.Crew()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `person` | `Record<string, any>` | No |  |
| `type` | `string` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Crew().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `CrewEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## CrewCreditEntity

```ts
const crew_credit = client.CrewCredit()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | `Record<string, any>` | No |  |
| `type` | `string` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.CrewCredit().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `CrewCreditEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## CrewMemberEntity

```ts
const crew_member = client.CrewMember()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `person` | `Record<string, any>` | No |  |
| `type` | `string` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.CrewMember().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `CrewMemberEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## EpisodeEntity

```ts
const episode = client.Episode()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `string` | No |  |
| `airstamp` | `string` | No |  |
| `airtime` | `string` | No |  |
| `id` | `number` | No |  |
| `image` | `Record<string, any>` | No |  |
| `link` | `Record<string, any>` | No |  |
| `name` | `string` | No |  |
| `number` | `number` | No |  |
| `rating` | `Record<string, any>` | No |  |
| `runtime` | `number` | No |  |
| `season` | `number` | No |  |
| `summary` | `string` | No |  |
| `type` | `string` | No |  |
| `url` | `string` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Episode().list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Episode().load({ id: 1 })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `EpisodeEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## GuestCastCreditEntity

```ts
const guest_cast_credit = client.GuestCastCredit()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | `Record<string, any>` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.GuestCastCredit().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `GuestCastCreditEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ImageEntity

```ts
const image = client.Image()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `number` | No |  |
| `main` | `boolean` | No |  |
| `resolution` | `Record<string, any>` | No |  |
| `type` | `string` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Image().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ImageEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## PersonEntity

```ts
const person = client.Person()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday` | `string` | No |  |
| `country` | `Record<string, any>` | No |  |
| `deathday` | `string` | No |  |
| `gender` | `string` | No |  |
| `id` | `number` | No |  |
| `image` | `Record<string, any>` | No |  |
| `link` | `Record<string, any>` | No |  |
| `name` | `string` | No |  |
| `person` | `Record<string, any>` | No |  |
| `score` | `number` | No |  |
| `updated` | `number` | No |  |
| `url` | `string` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Person().list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Person().load({ id: 1 })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `PersonEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ScheduleEntity

```ts
const schedule = client.Schedule()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `string` | No |  |
| `airstamp` | `string` | No |  |
| `airtime` | `string` | No |  |
| `id` | `number` | No |  |
| `image` | `Record<string, any>` | No |  |
| `link` | `Record<string, any>` | No |  |
| `name` | `string` | No |  |
| `number` | `number` | No |  |
| `rating` | `Record<string, any>` | No |  |
| `runtime` | `number` | No |  |
| `season` | `number` | No |  |
| `show` | `Record<string, any>` | No |  |
| `summary` | `string` | No |  |
| `type` | `string` | No |  |
| `url` | `string` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Schedule().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ScheduleEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ScheduledEpisodeEntity

```ts
const scheduled_episode = client.ScheduledEpisode()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `string` | No |  |
| `airstamp` | `string` | No |  |
| `airtime` | `string` | No |  |
| `id` | `number` | No |  |
| `image` | `Record<string, any>` | No |  |
| `link` | `Record<string, any>` | No |  |
| `name` | `string` | No |  |
| `number` | `number` | No |  |
| `rating` | `Record<string, any>` | No |  |
| `runtime` | `number` | No |  |
| `season` | `number` | No |  |
| `show` | `Record<string, any>` | No |  |
| `summary` | `string` | No |  |
| `type` | `string` | No |  |
| `url` | `string` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.ScheduledEpisode().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ScheduledEpisodeEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## SearchEntity

```ts
const search = client.Search()
```

### Operations

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Search().load()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `SearchEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## SeasonEntity

```ts
const season = client.Season()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `end_date` | `string` | No |  |
| `episode_order` | `number` | No |  |
| `id` | `number` | No |  |
| `image` | `Record<string, any>` | No |  |
| `link` | `Record<string, any>` | No |  |
| `name` | `string` | No |  |
| `network` | `Record<string, any>` | No |  |
| `number` | `number` | No |  |
| `premiere_date` | `string` | No |  |
| `summary` | `string` | No |  |
| `url` | `string` | No |  |
| `web_channel` | `Record<string, any>` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Season().list()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `SeasonEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## ShowEntity

```ts
const show = client.Show()
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `average_runtime` | `number` | No |  |
| `dvd_country` | `Record<string, any>` | No |  |
| `ended` | `string` | No |  |
| `external` | `Record<string, any>` | No |  |
| `genre` | `any[]` | No |  |
| `id` | `number` | No |  |
| `image` | `Record<string, any>` | No |  |
| `language` | `string` | No |  |
| `link` | `Record<string, any>` | No |  |
| `name` | `string` | No |  |
| `network` | `Record<string, any>` | No |  |
| `official_site` | `string` | No |  |
| `premiered` | `string` | No |  |
| `rating` | `Record<string, any>` | No |  |
| `runtime` | `number` | No |  |
| `schedule` | `Record<string, any>` | No |  |
| `score` | `number` | No |  |
| `show` | `Record<string, any>` | No |  |
| `status` | `string` | No |  |
| `summary` | `string` | No |  |
| `type` | `string` | No |  |
| `updated` | `number` | No |  |
| `url` | `string` | No |  |
| `web_channel` | `Record<string, any>` | No |  |
| `weight` | `number` | No |  |

### Operations

#### `list(match: object, ctrl?: object)`

List entities matching the given criteria. Returns an array.

```ts
const results = await client.Show().list()
```

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Show().load({ id: 1 })
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `ShowEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## UpdateEntity

```ts
const update = client.Update()
```

### Operations

#### `load(match: object, ctrl?: object)`

Load a single entity matching the given criteria.

```ts
const result = await client.Update().load()
```

### Common Methods

#### `data(data?: object)`

Get or set the entity data. When called with data, sets the entity's
internal data and returns the current data. When called without
arguments, returns a copy of the current data.

#### `match(match?: object)`

Get or set the entity match criteria. Works the same as `data()`.

#### `make()`

Create a new `UpdateEntity` instance with the same client and
options.

#### `client()`

Return the parent `TvmazeSDK` instance.

#### `entopts()`

Return a copy of the entity options.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```ts
const client = new TvmazeSDK({
  feature: {
    test: { active: true },
  }
})
```

