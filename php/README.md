# Tvmaze PHP SDK



The PHP SDK for the Tvmaze API — an entity-oriented client using PHP conventions.

> Other languages, the CLI, and MCP server live alongside this one — see
> the [top-level README](../README.md).


## Install
This package is not yet published to Packagist. Install it from the
GitHub release tag (`php/vX.Y.Z`):

- Releases: [https://github.com/voxgig-sdk/tvmaze-sdk/releases](https://github.com/voxgig-sdk/tvmaze-sdk/releases)


## Tutorial: your first API call

This tutorial walks through creating a client, listing entities, and
loading a specific record.

### 1. Create a client

```php
<?php
require_once 'tvmaze_sdk.php';

$client = new TvmazeSDK();
```

### 2. List aka records

```php
try {
    // list() returns an array of Aka records — iterate directly.
    $akas = $client->Aka()->list();
    foreach ($akas as $item) {
        echo $item["id"] . " " . $item["name"] . "\n";
    }
} catch (\Throwable $err) {
    echo "Error: " . $err->getMessage();
}
```


## How-to guides

### Make a direct HTTP request

For endpoints not covered by entity methods:

```php
// direct() is the raw-HTTP escape hatch: it returns a result array
// (it does not throw). Branch on $result["ok"].
$result = $client->direct([
    "path" => "/api/resource/{id}",
    "method" => "GET",
    "params" => ["id" => "example"],
]);

if ($result["ok"]) {
    echo $result["status"];  // 200
    print_r($result["data"]);  // response body
} else {
    echo "Error: " . $result["err"]->getMessage();
}
```

### Prepare a request without sending it

```php
// prepare() throws on error and returns the fetch definition.
$fetchdef = $client->prepare([
    "path" => "/api/resource/{id}",
    "method" => "DELETE",
    "params" => ["id" => "example"],
]);

echo $fetchdef["url"];
echo $fetchdef["method"];
print_r($fetchdef["headers"]);
```

### Use test mode

Create a mock client for unit testing — no server required. Seed fixture
data via the `entity` option so offline calls resolve without a live server:

```php
$client = TvmazeSDK::test([
    "entity" => ["aka" => ["test01" => ["id" => "test01"]]],
]);

// load() returns the bare mock record (throws on error).
$aka = $client->Aka()->load(["id" => "test01"]);
print_r($aka);
```

### Use a custom fetch function

Replace the HTTP transport with your own function:

```php
$mock_fetch = function ($url, $init) {
    return [
        [
            "status" => 200,
            "statusText" => "OK",
            "headers" => [],
            "json" => function () { return ["id" => "mock01"]; },
        ],
        null,
    ];
};

$client = new TvmazeSDK([
    "base" => "http://localhost:8080",
    "system" => [
        "fetch" => $mock_fetch,
    ],
]);
```

### Run live tests

Create a `.env.local` file at the project root:

```
TVMAZE_TEST_LIVE=TRUE
```

Then run:

```bash
cd php && ./vendor/bin/phpunit test/
```


## Reference

### TvmazeSDK

```php
require_once 'tvmaze_sdk.php';
$client = new TvmazeSDK($options);
```

Creates a new SDK client.

| Option | Type | Description |
| --- | --- | --- |
| `base` | `string` | Base URL of the API server. |
| `prefix` | `string` | URL path prefix prepended to all requests. |
| `suffix` | `string` | URL path suffix appended to all requests. |
| `feature` | `array` | Feature activation flags. |
| `extend` | `array` | Additional Feature instances to load. |
| `system` | `array` | System overrides (e.g. custom `fetch` callable). |

### test

```php
$client = TvmazeSDK::test($testopts, $sdkopts);
```

Creates a test-mode client with mock transport. Both arguments may be `null`.

### TvmazeSDK methods

| Method | Signature | Description |
| --- | --- | --- |
| `options_map` | `(): array` | Deep copy of current SDK options. |
| `get_utility` | `(): Utility` | Copy of the SDK utility object. |
| `prepare` | `(array $fetchargs): array` | Build an HTTP request definition without sending. |
| `direct` | `(array $fetchargs): array` | Build and send an HTTP request. |
| `Aka` | `($data): AkaEntity` | Create an Aka entity instance. |
| `AlternateList` | `($data): AlternateListEntity` | Create an AlternateList entity instance. |
| `Cast` | `($data): CastEntity` | Create a Cast entity instance. |
| `CastCredit` | `($data): CastCreditEntity` | Create a CastCredit entity instance. |
| `CastMember` | `($data): CastMemberEntity` | Create a CastMember entity instance. |
| `Crew` | `($data): CrewEntity` | Create a Crew entity instance. |
| `CrewCredit` | `($data): CrewCreditEntity` | Create a CrewCredit entity instance. |
| `CrewMember` | `($data): CrewMemberEntity` | Create a CrewMember entity instance. |
| `Episode` | `($data): EpisodeEntity` | Create an Episode entity instance. |
| `GuestCastCredit` | `($data): GuestCastCreditEntity` | Create a GuestCastCredit entity instance. |
| `Image` | `($data): ImageEntity` | Create an Image entity instance. |
| `Person` | `($data): PersonEntity` | Create a Person entity instance. |
| `Schedule` | `($data): ScheduleEntity` | Create a Schedule entity instance. |
| `ScheduledEpisode` | `($data): ScheduledEpisodeEntity` | Create a ScheduledEpisode entity instance. |
| `Search` | `($data): SearchEntity` | Create a Search entity instance. |
| `Season` | `($data): SeasonEntity` | Create a Season entity instance. |
| `Show` | `($data): ShowEntity` | Create a Show entity instance. |
| `Update` | `($data): UpdateEntity` | Create an Update entity instance. |

### Entity interface

All entities share the same interface.

| Method | Signature | Description |
| --- | --- | --- |
| `load` | `($reqmatch, $ctrl): array` | Load a single entity by match criteria. |
| `list` | `($reqmatch, $ctrl): array` | List entities matching the criteria. |
| `create` | `($reqdata, $ctrl): array` | Create a new entity. |
| `update` | `($reqdata, $ctrl): array` | Update an existing entity. |
| `remove` | `($reqmatch, $ctrl): array` | Remove an entity. |
| `data_get` | `(): array` | Get entity data. |
| `data_set` | `($data): void` | Set entity data. |
| `match_get` | `(): array` | Get entity match criteria. |
| `match_set` | `($match): void` | Set entity match criteria. |
| `make` | `(): Entity` | Create a new instance with the same options. |
| `get_name` | `(): string` | Return the entity name. |

### Result shape

Entity operations return the bare result data (an `array` for single-entity
ops, a `list` for `list`) and throw on error. Wrap calls in
`try`/`catch` to handle failures.

The `direct()` escape hatch never throws — it returns a result `array`
you branch on via `$result["ok"]`:

| Key | Type | Description |
| --- | --- | --- |
| `ok` | `bool` | `true` if the HTTP status is 2xx. |
| `status` | `int` | HTTP status code. |
| `headers` | `array` | Response headers. |
| `data` | `mixed` | Parsed JSON response body. |

On error, `ok` is `false` and `$err` contains the error value.

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

Create an instance: `$aka = $client->Aka();`

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

```php
// list() returns an array of Aka records (throws on error).
$akas = $client->Aka()->list();
```


### AlternateList

Create an instance: `$alternate_list = $client->AlternateList();`

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

```php
// load() returns the bare AlternateList record (throws on error).
$alternate_list = $client->AlternateList()->load(["id" => "alternate_list_id"]);
```

#### Example: List

```php
// list() returns an array of AlternateList records (throws on error).
$alternate_lists = $client->AlternateList()->list();
```


### Cast

Create an instance: `$cast = $client->Cast();`

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

```php
// list() returns an array of Cast records (throws on error).
$casts = $client->Cast()->list();
```


### CastCredit

Create an instance: `$cast_credit = $client->CastCredit();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `link` | ``$OBJECT`` |  |

#### Example: List

```php
// list() returns an array of CastCredit records (throws on error).
$cast_credits = $client->CastCredit()->list();
```


### CastMember

Create an instance: `$cast_member = $client->CastMember();`

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

```php
// list() returns an array of CastMember records (throws on error).
$cast_members = $client->CastMember()->list();
```


### Crew

Create an instance: `$crew = $client->Crew();`

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

```php
// list() returns an array of Crew records (throws on error).
$crews = $client->Crew()->list();
```


### CrewCredit

Create an instance: `$crew_credit = $client->CrewCredit();`

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

```php
// list() returns an array of CrewCredit records (throws on error).
$crew_credits = $client->CrewCredit()->list();
```


### CrewMember

Create an instance: `$crew_member = $client->CrewMember();`

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

```php
// list() returns an array of CrewMember records (throws on error).
$crew_members = $client->CrewMember()->list();
```


### Episode

Create an instance: `$episode = $client->Episode();`

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

```php
// load() returns the bare Episode record (throws on error).
$episode = $client->Episode()->load(["id" => "episode_id"]);
```

#### Example: List

```php
// list() returns an array of Episode records (throws on error).
$episodes = $client->Episode()->list();
```


### GuestCastCredit

Create an instance: `$guest_cast_credit = $client->GuestCastCredit();`

#### Operations

| Method | Description |
| --- | --- |
| `list(match)` | List entities matching the criteria. |

#### Fields

| Field | Type | Description |
| --- | --- | --- |
| `link` | ``$OBJECT`` |  |

#### Example: List

```php
// list() returns an array of GuestCastCredit records (throws on error).
$guest_cast_credits = $client->GuestCastCredit()->list();
```


### Image

Create an instance: `$image = $client->Image();`

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

```php
// list() returns an array of Image records (throws on error).
$images = $client->Image()->list();
```


### Person

Create an instance: `$person = $client->Person();`

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

```php
// load() returns the bare Person record (throws on error).
$person = $client->Person()->load(["id" => "person_id"]);
```

#### Example: List

```php
// list() returns an array of Person records (throws on error).
$persons = $client->Person()->list();
```


### Schedule

Create an instance: `$schedule = $client->Schedule();`

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

```php
// list() returns an array of Schedule records (throws on error).
$schedules = $client->Schedule()->list();
```


### ScheduledEpisode

Create an instance: `$scheduled_episode = $client->ScheduledEpisode();`

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

```php
// list() returns an array of ScheduledEpisode records (throws on error).
$scheduled_episodes = $client->ScheduledEpisode()->list();
```


### Search

Create an instance: `$search = $client->Search();`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```php
// load() returns the bare Search record (throws on error).
$search = $client->Search()->load(["id" => "search_id"]);
```


### Season

Create an instance: `$season = $client->Season();`

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

```php
// list() returns an array of Season records (throws on error).
$seasons = $client->Season()->list();
```


### Show

Create an instance: `$show = $client->Show();`

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

```php
// load() returns the bare Show record (throws on error).
$show = $client->Show()->load(["id" => "show_id"]);
```

#### Example: List

```php
// list() returns an array of Show records (throws on error).
$shows = $client->Show()->list();
```


### Update

Create an instance: `$update = $client->Update();`

#### Operations

| Method | Description |
| --- | --- |
| `load(match)` | Load a single entity by match criteria. |

#### Example: Load

```php
// load() returns the bare Update record (throws on error).
$update = $client->Update()->load(["id" => "update_id"]);
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
error is returned to the caller as the second element in the return array.

### Features and hooks

Features are the extension mechanism. A feature is a PHP class
with hook methods named after pipeline stages (e.g. `PrePoint`,
`PreSpec`). Each method receives the context.

The SDK ships with built-in features:

- **TestFeature**: In-memory mock transport for testing without a live server

Features are initialized in order. Hooks fire in the order features
were added, so later features can override earlier ones.

### Data as arrays

The PHP SDK uses plain PHP associative arrays throughout rather than typed
objects. This mirrors the dynamic nature of the API and keeps the
SDK flexible — no code generation is needed when the API schema
changes.

Use `Helpers::to_map()` to safely validate that a value is an array.

### Directory structure

```
php/
├── tvmaze_sdk.php          -- Main SDK class
├── config.php                     -- Configuration
├── features.php                   -- Feature factory
├── core/                          -- Core types and context
├── entity/                        -- Entity implementations
├── feature/                       -- Built-in features (Base, Test, Log)
├── utility/                       -- Utility functions and struct library
└── test/                          -- Test suites
```

The main class (`tvmaze_sdk.php`) exports the SDK class
and test helper. Import entity or utility modules directly only
when needed.

### Entity state

Entity instances are stateful. After a successful `load`, the entity
stores the returned data and match criteria internally.

```php
$aka = $client->Aka();
$aka->load(["id" => "example_id"]);

// $aka->dataGet() now returns the loaded aka data
// $aka->matchGet() returns the last match criteria
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
