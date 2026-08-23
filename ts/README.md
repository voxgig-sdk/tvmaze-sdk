# Tvmaze TypeScript SDK



The TypeScript SDK for the Tvmaze API — a type-safe, entity-oriented client with full async/await support.

The API is exposed as capitalised, semantic **Entities** — e.g.
`client.Aka()` — each with a small set of operations (`list`, `load`)
instead of raw URL paths and query parameters. This keeps the surface
predictable and low-friction for both humans and AI agents.

> Also generated from this model: `go`, `go-cli`, `go-mcp`, `lua`, `php`, `py`, `rb` — see
> the [top-level README](../README.md).


## Install
This package is not yet published to npm. Install it from the GitHub
release tag (`ts/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/tvmaze-sdk/releases](https://github.com/voxgig-sdk/tvmaze-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```ts
import { TvmazeSDK } from '@voxgig-sdk/tvmaze'

const client = new TvmazeSDK()
```

### 2. List aka records

`list()` resolves to an array of Aka ENTITIES — every operation
resolves to entities, not raw records. Iterate them directly, and call
`.data()` on one for the record it holds:

```ts
const akas = await client.Aka().list({ show_id: 1 })

for (const aka of akas) {
  console.log(aka)
}
```


## Error handling

Entity operations reject on failure, so wrap them in `try` / `catch`:

```ts
try {
  const images = await client.Image().list()
  console.log(images)
} catch (err) {
  console.error('list failed:', err)
}
```

The low-level `direct()` method does **not** throw — it returns the
value or an `Error`, so check the result before using it:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example_id' },
})

if (result instanceof Error) {
  throw result
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```ts
const result = await client.direct({
  path: '/api/resource/{id}',
  method: 'GET',
  params: { id: 'example' },
})

if (result instanceof Error) {
  throw result
}
if (result.ok) {
  console.log(result.status)  // 200
  console.log(result.data)    // response body
}
```

### Prepare a request without sending it

```ts
const fetchdef = await client.prepare({
  path: '/api/resource/{id}',
  method: 'DELETE',
  params: { id: 'example' },
})

// Inspect before sending
console.log(fetchdef.url)
console.log(fetchdef.method)
console.log(fetchdef.headers)
```

### Use test mode

Create a mock client for unit testing — no server required:

```ts
const client = TvmazeSDK.test()

const image = await client.Image().list()
// image is the entity, populated with mock response data
// — call image.data() for the record itself
console.log(image)
```

You can also use the instance method:

```ts
const client = new TvmazeSDK()
const testClient = client.tester()
```

### Retain entity state across calls

Entity instances remember their last match and data:

```ts
const entity = client.Image()

// First call runs the operation and stores its result
await entity.list()

// Subsequent calls reuse the stored state
const data = entity.data()
console.log(data.id)
```

### Add custom middleware

Pass features via the `extend` option:

```ts
const logger = {
  hooks: {
    PreRequest: (ctx: any) => {
      console.log('Requesting:', ctx.spec.method, ctx.spec.path)
    },
    PreResponse: (ctx: any) => {
      console.log('Status:', ctx.out.request?.status)
    },
  },
}

const client = new TvmazeSDK({
  extend: [logger],
})
```

### Run live tests

Create a `.env.local` file at the project root:

```
TVMAZE_TEST_LIVE=TRUE
```

Then run:

```bash
cd ts && npm test
```


## Reference

### TvmazeSDK

#### Constructor

```ts
new TvmazeSDK(options?: {
  base?: string
  prefix?: string
  suffix?: string
  feature?: Record<string, { active: boolean }>
  extend?: Feature[]
})
```

| Option | Type | Description |
| --- | --- | --- |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `object` | Feature activation flags (e.g. `{ test: { active: true } }`). |
| `extend` | `Feature[]` | Additional feature instances to load. |

#### Methods

| Method | Returns | Description |
| --- | --- | --- |
| `options()` | `object` | Deep copy of current SDK options. |
| `utility()` | `Utility` | Deep copy of the SDK utility object. |
| `prepare(fetchargs?)` | `Promise<FetchDef>` | Build an HTTP request definition without sending it. |
| `direct(fetchargs?)` | `Promise<DirectResult>` | Build and send an HTTP request. |
| `Aka(data?)` | `AkaEntity` | Create an Aka entity instance. |
| `AlternateList(data?)` | `AlternateListEntity` | Create an AlternateList entity instance. |
| `Cast(data?)` | `CastEntity` | Create a Cast entity instance. |
| `CastCredit(data?)` | `CastCreditEntity` | Create a CastCredit entity instance. |
| `CastMember(data?)` | `CastMemberEntity` | Create a CastMember entity instance. |
| `Crew(data?)` | `CrewEntity` | Create a Crew entity instance. |
| `CrewCredit(data?)` | `CrewCreditEntity` | Create a CrewCredit entity instance. |
| `CrewMember(data?)` | `CrewMemberEntity` | Create a CrewMember entity instance. |
| `Episode(data?)` | `EpisodeEntity` | Create an Episode entity instance. |
| `GuestCastCredit(data?)` | `GuestCastCreditEntity` | Create a GuestCastCredit entity instance. |
| `Image(data?)` | `ImageEntity` | Create an Image entity instance. |
| `Person(data?)` | `PersonEntity` | Create a Person entity instance. |
| `Schedule(data?)` | `ScheduleEntity` | Create a Schedule entity instance. |
| `ScheduledEpisode(data?)` | `ScheduledEpisodeEntity` | Create a ScheduledEpisode entity instance. |
| `Search(data?)` | `SearchEntity` | Create a Search entity instance. |
| `Season(data?)` | `SeasonEntity` | Create a Season entity instance. |
| `Show(data?)` | `ShowEntity` | Create a Show entity instance. |
| `Update(data?)` | `UpdateEntity` | Create an Update entity instance. |
| `tester(testopts?, sdkopts?)` | `TvmazeSDK` | Create a test-mode client instance. |

#### Static methods

| Method | Returns | Description |
| --- | --- | --- |
| `TvmazeSDK.test(testopts?, sdkopts?)` | `TvmazeSDK` | Create a test-mode client. |

### Entity interface

All entities share the same interface.

#### Methods

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `load(reqmatch?, ctrl?): Promise<Entity>` | Load a single entity by match criteria. |
| `list` | `list(reqmatch?, ctrl?): Promise<Entity[]>` | List entities matching the criteria. |
| `data` | `data(data?: Partial<Entity>): Entity` | Get or set entity data. |
| `match` | `match(match?: Partial<Entity>): Partial<Entity>` | Get or set entity match criteria. |
| `make` | `make(): Entity` | Create a new instance with the same options. |
| `client` | `client(): TvmazeSDK` | Return the parent SDK client. |
| `entopts` | `entopts(): object` | Return a copy of the entity options. |

#### Return values

Entity operations resolve to the entity data directly — there is no
result envelope:

- `load` resolves to a single entity object.
- `list` resolves to an **array** of entity objects (iterate it directly;
  there is no `.data` and no `.ok`).

On a failed request these methods **throw**, so wrap calls in
`try`/`catch` to handle errors. Only `direct()` returns the result
envelope described below.

### DirectResult shape

The `direct()` method returns:

```ts
{
  ok: boolean
  status: number
  headers: object
  data: any
}
```

On error, `ok` is `false` and an `err` property contains the error.

### FetchDef shape

The `prepare()` method returns:

```ts
{
  url: string
  method: string
  headers: Record<string, string>
  body?: any
}
```

### Entities

#### Aka

| Field | Description |
| --- | --- |
| `country` |  |
| `name` | Alternate name |

Operations: list.

API path: `/shows/{id}/akas`

#### AlternateList

| Field | Description |
| --- | --- |
| `id` | Unique alternate list identifier |
| `links` |  |
| `name` | Name of alternate list (e.g., DVD Order) |
| `self` |  |
| `url` | TVmaze URL for the alternate list |

Operations: list, load.

API path: `/shows/{id}/alternatelists`

#### Cast

| Field | Description |
| --- | --- |
| `character` |  |
| `person` |  |
| `self` | Whether person plays themselves |
| `voice` | Whether this is a voice role |

Operations: list.

API path: `/shows/{id}/cast`

#### CastCredit

| Field | Description |
| --- | --- |
| `links` |  |

Operations: list.

API path: `/people/{id}/castcredits`

#### CastMember

| Field | Description |
| --- | --- |
| `character` |  |
| `person` |  |
| `self` | Whether person plays themselves |
| `voice` | Whether this is a voice role |

Operations: list.

API path: `/episodes/{id}/guestcast`

#### Crew

| Field | Description |
| --- | --- |
| `person` |  |
| `type` | Crew type (e.g., Executive Producer) |

Operations: list.

API path: `/shows/{id}/crew`

#### CrewCredit

| Field | Description |
| --- | --- |
| `links` |  |
| `type` | Crew type |

Operations: list.

API path: `/people/{id}/crewcredits`

#### CrewMember

| Field | Description |
| --- | --- |
| `person` |  |
| `type` | Crew type (e.g., Executive Producer) |

Operations: list.

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

Operations: list, load.

API path: `/shows/{id}/episodesbydate`

#### GuestCastCredit

| Field | Description |
| --- | --- |
| `links` |  |

Operations: list.

API path: `/people/{id}/guestcastcredits`

#### Image

| Field | Description |
| --- | --- |
| `id` | Unique image identifier |
| `main` | Whether this is the main image |
| `resolutions` |  |
| `type` | Image type |

Operations: list.

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

Operations: list, load.

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

Operations: list.

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

Operations: list.

API path: `/schedule/web`

#### Search

| Field | Description |
| --- | --- |

Operations: load.

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

Operations: list.

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

Operations: list, load.

API path: `/alternatelists/{id}/alternateepisodes`

#### Update

| Field | Description |
| --- | --- |

Operations: load.

API path: `/updates/people`



## Entities


### Aka

Create an instance: `const aka = client.Aka()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `country` | `Record<string, any>` |  |
| `name` | `string` | Alternate name |

#### Example: List

```ts
const akas = await client.Aka().list({ show_id: 1 })
```


### AlternateList

Create an instance: `const alternate_list = client.AlternateList()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `number` | Unique alternate list identifier |
| `links` | `Record<string, any>` |  |
| `name` | `string` | Name of alternate list (e.g., DVD Order) |
| `self` | `Record<string, any>` |  |
| `url` | `string` | TVmaze URL for the alternate list |

#### Example: Load

```ts
const alternate_list = await client.AlternateList().load({ id: 1 })
```

#### Example: List

```ts
const alternate_lists = await client.AlternateList().list({ show_id: 1 })
```


### Cast

Create an instance: `const cast = client.Cast()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `character` | `Record<string, any>` |  |
| `person` | `Record<string, any>` |  |
| `self` | `boolean` | Whether person plays themselves |
| `voice` | `boolean` | Whether this is a voice role |

#### Example: List

```ts
const casts = await client.Cast().list({ show_id: 1 })
```


### CastCredit

Create an instance: `const cast_credit = client.CastCredit()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `links` | `Record<string, any>` |  |

#### Example: List

```ts
const cast_credits = await client.CastCredit().list({ person_id: 1 })
```


### CastMember

Create an instance: `const cast_member = client.CastMember()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `character` | `Record<string, any>` |  |
| `person` | `Record<string, any>` |  |
| `self` | `boolean` | Whether person plays themselves |
| `voice` | `boolean` | Whether this is a voice role |

#### Example: List

```ts
const cast_members = await client.CastMember().list({ episode_id: 1 })
```


### Crew

Create an instance: `const crew = client.Crew()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `person` | `Record<string, any>` |  |
| `type` | `string` | Crew type (e.g., Executive Producer) |

#### Example: List

```ts
const crews = await client.Crew().list({ show_id: 1 })
```


### CrewCredit

Create an instance: `const crew_credit = client.CrewCredit()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `links` | `Record<string, any>` |  |
| `type` | `string` | Crew type |

#### Example: List

```ts
const crew_credits = await client.CrewCredit().list({ person_id: 1 })
```


### CrewMember

Create an instance: `const crew_member = client.CrewMember()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `person` | `Record<string, any>` |  |
| `type` | `string` | Crew type (e.g., Executive Producer) |

#### Example: List

```ts
const crew_members = await client.CrewMember().list({ episode_id: 1 })
```


### Episode

Create an instance: `const episode = client.Episode()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `airdate` | `string` | Air date |
| `airstamp` | `string` | Air timestamp |
| `airtime` | `string` | Air time |
| `id` | `number` | Unique episode identifier |
| `image` | `Record<string, any>` |  |
| `links` | `Record<string, any>` |  |
| `name` | `string` | Episode name |
| `number` | `number` | Episode number in season |
| `rating` | `Record<string, any>` |  |
| `runtime` | `number` | Runtime in minutes |
| `season` | `number` | Season number |
| `summary` | `string` | HTML summary |
| `type` | `string` | Episode type (e.g., regular, significant_special) |
| `url` | `string` | TVmaze URL for the episode |

#### Example: Load

```ts
const episode = await client.Episode().load({ id: 1 })
```

#### Example: List

```ts
const episodes = await client.Episode().list({ show_id: 1 })
```


### GuestCastCredit

Create an instance: `const guest_cast_credit = client.GuestCastCredit()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `links` | `Record<string, any>` |  |

#### Example: List

```ts
const guest_cast_credits = await client.GuestCastCredit().list({ person_id: 1 })
```


### Image

Create an instance: `const image = client.Image()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `id` | `number` | Unique image identifier |
| `main` | `boolean` | Whether this is the main image |
| `resolutions` | `Record<string, any>` |  |
| `type` | `string` | Image type |

#### Example: List

```ts
const images = await client.Image().list({ show_id: 1 })
```


### Person

Create an instance: `const person = client.Person()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `birthday` | `string` | Birth date |
| `country` | `Record<string, any>` |  |
| `deathday` | `string` | Death date |
| `gender` | `string` | Gender |
| `id` | `number` | Unique person identifier |
| `image` | `Record<string, any>` |  |
| `links` | `Record<string, any>` |  |
| `name` | `string` | Person name |
| `person` | `Record<string, any>` |  |
| `score` | `number` | Search relevancy score |
| `updated` | `number` | Unix timestamp of last update |
| `url` | `string` | TVmaze URL for the person |

#### Example: Load

```ts
const person = await client.Person().load({ id: 1 })
```

#### Example: List

```ts
const persons = await client.Person().list()
```


### Schedule

Create an instance: `const schedule = client.Schedule()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `airdate` | `string` | Air date |
| `airstamp` | `string` | Air timestamp |
| `airtime` | `string` | Air time |
| `id` | `number` | Unique episode identifier |
| `image` | `Record<string, any>` |  |
| `links` | `Record<string, any>` |  |
| `name` | `string` | Episode name |
| `number` | `number` | Episode number in season |
| `rating` | `Record<string, any>` |  |
| `runtime` | `number` | Runtime in minutes |
| `season` | `number` | Season number |
| `show` | `Record<string, any>` |  |
| `summary` | `string` | HTML summary |
| `type` | `string` | Episode type (e.g., regular, significant_special) |
| `url` | `string` | TVmaze URL for the episode |

#### Example: List

```ts
const schedules = await client.Schedule().list()
```


### ScheduledEpisode

Create an instance: `const scheduled_episode = client.ScheduledEpisode()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `airdate` | `string` | Air date |
| `airstamp` | `string` | Air timestamp |
| `airtime` | `string` | Air time |
| `id` | `number` | Unique episode identifier |
| `image` | `Record<string, any>` |  |
| `links` | `Record<string, any>` |  |
| `name` | `string` | Episode name |
| `number` | `number` | Episode number in season |
| `rating` | `Record<string, any>` |  |
| `runtime` | `number` | Runtime in minutes |
| `season` | `number` | Season number |
| `show` | `Record<string, any>` |  |
| `summary` | `string` | HTML summary |
| `type` | `string` | Episode type (e.g., regular, significant_special) |
| `url` | `string` | TVmaze URL for the episode |

#### Example: List

```ts
const scheduled_episodes = await client.ScheduledEpisode().list()
```


### Search

Create an instance: `const search = client.Search()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ts
const search = await client.Search().load()
```


### Season

Create an instance: `const season = client.Season()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `endDate` | `string` | End date |
| `episodeOrder` | `number` | Number of episodes |
| `id` | `number` | Unique season identifier |
| `image` | `Record<string, any>` |  |
| `links` | `Record<string, any>` |  |
| `name` | `string` | Season name |
| `network` | `Record<string, any>` |  |
| `number` | `number` | Season number |
| `premiereDate` | `string` | Premiere date |
| `summary` | `string` | HTML summary |
| `url` | `string` | TVmaze URL for the season |
| `webChannel` | `Record<string, any>` |  |

#### Example: List

```ts
const seasons = await client.Season().list({ show_id: 1 })
```


### Show

Create an instance: `const show = client.Show()`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |
| `load(match)` | Load a single entity by match criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `averageRuntime` | `number` | Average runtime in minutes |
| `dvdCountry` | `Record<string, any>` |  |
| `ended` | `string` | End date |
| `externals` | `Record<string, any>` |  |
| `genres` | `any[]` | List of genres |
| `id` | `number` | Unique show identifier |
| `image` | `Record<string, any>` |  |
| `language` | `string` | Original language |
| `links` | `Record<string, any>` |  |
| `name` | `string` | Show name |
| `network` | `Record<string, any>` |  |
| `officialSite` | `string` | Official website URL |
| `premiered` | `string` | Premiere date |
| `rating` | `Record<string, any>` |  |
| `runtime` | `number` | Runtime in minutes |
| `schedule` | `Record<string, any>` |  |
| `score` | `number` | Search relevancy score |
| `show` | `Record<string, any>` |  |
| `status` | `string` | Current status (e.g., Running, Ended) |
| `summary` | `string` | HTML summary |
| `type` | `string` | Show type (e.g., Scripted, Reality) |
| `updated` | `number` | Unix timestamp of last update |
| `url` | `string` | TVmaze URL for the show |
| `webChannel` | `Record<string, any>` |  |
| `weight` | `number` | Show weight/importance |

#### Example: Load

```ts
const show = await client.Show().load({ id: 1 })
```

#### Example: List

```ts
const shows = await client.Show().list()
```


### Update

Create an instance: `const update = client.Update()`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```ts
const update = await client.Update().load()
```


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

Features are the extension mechanism. A feature is an object with a
`hooks` map. Each hook key is a pipeline stage name, and the value is
a function that receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Module structure

```
tvmaze/
├── src/
│   ├── TvmazeSDK.ts        # Main SDK class
│   ├── entity/             # Entity implementations
│   ├── feature/            # Built-in features (Base, Test, Log)
│   └── utility/            # Utility functions
├── test/                   # Test suites
└── dist/                   # Compiled output
```

Import the SDK from the package root:

```ts
import { TvmazeSDK } from '@voxgig-sdk/tvmaze'
```

### Entity state

Entity instances are stateful. After a successful `list`, the entity
stores the returned data and match criteria internally. Subsequent
calls on the same instance can rely on this state.

```ts
const image = client.Image()
await image.list()

// image.data() now returns the image data from the last `list`
// image.match() returns the last match criteria
```

Call `make()` to create a fresh instance with the same configuration
but no stored state.

### Direct vs entity access

The entity interface handles URL construction, parameter placement,
and response parsing automatically. Use it for standard CRUD operations.

The `direct` method gives full control over the HTTP request. Use it
for non-standard endpoints, bulk operations, or any path not modelled
as an entity. The `prepare` method is useful for debugging — it
shows exactly what `direct` would send.


## Full Reference

See [REFERENCE.md](REFERENCE.md) for complete API reference
documentation including all method signatures, entity field schemas,
and detailed usage examples.
