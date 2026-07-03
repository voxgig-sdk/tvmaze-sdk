# Tvmaze Lua SDK



The Lua SDK for the Tvmaze API — an entity-oriented client using Lua conventions.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
```bash
luarocks install tvmaze-sdk
```

If the module is not yet published, add the source directory to
your `LUA_PATH`:

```bash
export LUA_PATH="path/to/lua/?.lua;path/to/lua/?/init.lua;;"
```


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```lua
local sdk = require("tvmaze_sdk")

local client = sdk.new({
  apikey = os.getenv("TVMAZE_APIKEY"),
})
```

### 2. List akas

```lua
local result, err = client:Aka():list()
if err then error(err) end

if type(result) == "table" then
  for _, item in ipairs(result) do
    local d = item:data_get()
    print(d["id"], d["name"])
  end
end
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```lua
local result, err = client:direct({
  path = "/api/resource/{id}",
  method = "GET",
  params = { id = "example" },
})
if err then error(err) end

if result["ok"] then
  print(result["status"])  -- 200
  print(result["data"])    -- response body
end
```

### Prepare a request without sending it

```lua
local fetchdef, err = client:prepare({
  path = "/api/resource/{id}",
  method = "DELETE",
  params = { id = "example" },
})
if err then error(err) end

print(fetchdef["url"])
print(fetchdef["method"])
print(fetchdef["headers"])
```

### Use test mode

Create a mock client for unit testing — no server required:

```lua
local client = sdk.test()

local result, err = client:Tvmaze():load({ id = "test01" })
-- result contains mock response data
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```lua
local function mock_fetch(url, init)
  return {
    status = 200,
    statusText = "OK",
    headers = {},
    json = function()
      return { id = "mock01" }
    end,
  }, nil
end

local client = sdk.new({
  base = "http://localhost:8080",
  system = {
    fetch = mock_fetch,
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
cd lua && busted test/
```


## Reference

### TvmazeSDK

```lua
local sdk = require("tvmaze_sdk")
local client = sdk.new(options)
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `apikey` | `string` | API key for authentication. |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `table` | Feature activation flags. |
| `extend` | `table` | Additional Feature instances to load. |
| `system` | `table` | System overrides (e.g. custom `fetch` function). |

### test

```lua
local client = sdk.test(testopts, sdkopts)
```

Creates a test-mode client with mock transport. Both arguments may be `nil`.

### TvmazeSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `() -> table` | Deep copy of current SDK options. |
| `get_utility` | `() -> Utility` | Copy of the SDK utility object. |
| `prepare` | `(fetchargs) -> table, err` | Build an HTTP request definition without sending. |
| `direct` | `(fetchargs) -> table, err` | Build and send an HTTP request. |
| `Aka` | `(data) -> AkaEntity` | Create a Aka entity instance. |
| `AlternateList` | `(data) -> AlternateListEntity` | Create a AlternateList entity instance. |
| `Cast` | `(data) -> CastEntity` | Create a Cast entity instance. |
| `CastCredit` | `(data) -> CastCreditEntity` | Create a CastCredit entity instance. |
| `CastMember` | `(data) -> CastMemberEntity` | Create a CastMember entity instance. |
| `Crew` | `(data) -> CrewEntity` | Create a Crew entity instance. |
| `CrewCredit` | `(data) -> CrewCreditEntity` | Create a CrewCredit entity instance. |
| `CrewMember` | `(data) -> CrewMemberEntity` | Create a CrewMember entity instance. |
| `Episode` | `(data) -> EpisodeEntity` | Create a Episode entity instance. |
| `GuestCastCredit` | `(data) -> GuestCastCreditEntity` | Create a GuestCastCredit entity instance. |
| `Image` | `(data) -> ImageEntity` | Create a Image entity instance. |
| `Person` | `(data) -> PersonEntity` | Create a Person entity instance. |
| `Schedule` | `(data) -> ScheduleEntity` | Create a Schedule entity instance. |
| `ScheduledEpisode` | `(data) -> ScheduledEpisodeEntity` | Create a ScheduledEpisode entity instance. |
| `Search` | `(data) -> SearchEntity` | Create a Search entity instance. |
| `Season` | `(data) -> SeasonEntity` | Create a Season entity instance. |
| `Show` | `(data) -> ShowEntity` | Create a Show entity instance. |
| `Update` | `(data) -> UpdateEntity` | Create a Update entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `(reqmatch, ctrl) -> any, err` | Load a single entity by match criteria. |
| `list` | `(reqmatch, ctrl) -> any, err` | List entities matching the criteria. |
| `create` | `(reqdata, ctrl) -> any, err` | Create a new entity. |
| `update` | `(reqdata, ctrl) -> any, err` | Update an existing entity. |
| `remove` | `(reqmatch, ctrl) -> any, err` | Remove an entity. |
| `data_get` | `() -> table` | Get entity data. |
| `data_set` | `(data)` | Set entity data. |
| `match_get` | `() -> table` | Get entity match criteria. |
| `match_set` | `(match)` | Set entity match criteria. |
| `make` | `() -> Entity` | Create a new instance with the same options. |
| `get_name` | `() -> string` | Return the entity name. |

### Result shape

Entity operations return `(any, err)`. The first value is a
`table` with these keys:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `boolean` | `true` if the HTTP status is 2xx. |
| `status` | `number` | HTTP status code. |
| `headers` | `table` | Response headers. |
| `data` | `any` | Parsed JSON response body. |

On error, `ok` is `false` and `err` contains the error value.

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

Create an instance: `const aka = client.Aka()`

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

```ts
const akas = await client.Aka().list()
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
| `id` | ``$INTEGER`` |  |
| `link` | ``$OBJECT`` |  |
| `name` | ``$STRING`` |  |
| `url` | ``$STRING`` |  |

#### Example: Load

```ts
const alternate_list = await client.AlternateList().load({ id: 'alternate_list_id' })
```

#### Example: List

```ts
const alternate_lists = await client.AlternateList().list()
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
| `character` | ``$OBJECT`` |  |
| `person` | ``$OBJECT`` |  |
| `self` | ``$BOOLEAN`` |  |
| `voice` | ``$BOOLEAN`` |  |

#### Example: List

```ts
const casts = await client.Cast().list()
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
| `link` | ``$OBJECT`` |  |

#### Example: List

```ts
const cast_credits = await client.CastCredit().list()
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
| `character` | ``$OBJECT`` |  |
| `person` | ``$OBJECT`` |  |
| `self` | ``$BOOLEAN`` |  |
| `voice` | ``$BOOLEAN`` |  |

#### Example: List

```ts
const cast_members = await client.CastMember().list()
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
| `person` | ``$OBJECT`` |  |
| `type` | ``$STRING`` |  |

#### Example: List

```ts
const crews = await client.Crew().list()
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
| `link` | ``$OBJECT`` |  |
| `type` | ``$STRING`` |  |

#### Example: List

```ts
const crew_credits = await client.CrewCredit().list()
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
| `person` | ``$OBJECT`` |  |
| `type` | ``$STRING`` |  |

#### Example: List

```ts
const crew_members = await client.CrewMember().list()
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

```ts
const episode = await client.Episode().load({ id: 'episode_id' })
```

#### Example: List

```ts
const episodes = await client.Episode().list()
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
| `link` | ``$OBJECT`` |  |

#### Example: List

```ts
const guest_cast_credits = await client.GuestCastCredit().list()
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
| `id` | ``$INTEGER`` |  |
| `main` | ``$BOOLEAN`` |  |
| `resolution` | ``$OBJECT`` |  |
| `type` | ``$STRING`` |  |

#### Example: List

```ts
const images = await client.Image().list()
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

```ts
const person = await client.Person().load({ id: 'person_id' })
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
const search = await client.Search().load({ id: 'search_id' })
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

```ts
const seasons = await client.Season().list()
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

```ts
const show = await client.Show().load({ id: 'show_id' })
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
const update = await client.Update().load({ id: 'update_id' })
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
error is returned to the caller as a second return value.

### Features and hooks

Features are the extension mechanism. A feature is a Lua table
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as tables

The Lua SDK uses plain Lua tables throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `helpers.to_map()` to safely validate that a value is a table.

### Module structure

```
lua/
├── tvmaze_sdk.lua    -- Main SDK module
├── config.lua               -- Configuration
├── features.lua             -- Feature factory
├── core/                    -- Core types and context
├── entity/                  -- Entity implementations
├── feature/                 -- Built-in features (Base, Test, Log)
├── utility/                 -- Utility functions and struct library
└── test/                    -- Test suites
```

The main module (`tvmaze_sdk`) exports the SDK constructor
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally.

```lua
local moon = client:Moon(nil)
moon:load({ planet_id = "earth", id = "luna" }, nil)

-- moon:data_get() now returns the loaded moon data
-- moon:match_get() returns the last match criteria
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
