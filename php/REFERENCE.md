# Tvmaze PHP SDK Reference

Complete API reference for the Tvmaze PHP SDK.


## TvmazeSDK

### Constructor

```php
require_once __DIR__ . '/tvmaze_sdk.php';

$client = new TvmazeSDK($options);
```

Create a new SDK client instance.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$options` | `array` | SDK configuration options. |
| `$options["base"]` | `string` | Base URL for API requests. |
| `$options["prefix"]` | `string` | URL prefix appended after base. |
| `$options["suffix"]` | `string` | URL suffix appended after path. |
| `$options["headers"]` | `array` | Custom headers for all requests. |
| `$options["feature"]` | `array` | Feature configuration. |
| `$options["system"]` | `array` | System overrides (e.g. custom fetch). |


### Static Methods

#### `TvmazeSDK::test($testopts = null, $sdkopts = null)`

Create a test client with mock features active. Both arguments may be `null`.

```php
$client = TvmazeSDK::test();
```


### Instance Methods

#### `Aka($data = null)`

Create a new `AkaEntity` instance. Pass `null` for no initial data.

#### `AlternateList($data = null)`

Create a new `AlternateListEntity` instance. Pass `null` for no initial data.

#### `Cast($data = null)`

Create a new `CastEntity` instance. Pass `null` for no initial data.

#### `CastCredit($data = null)`

Create a new `CastCreditEntity` instance. Pass `null` for no initial data.

#### `CastMember($data = null)`

Create a new `CastMemberEntity` instance. Pass `null` for no initial data.

#### `Crew($data = null)`

Create a new `CrewEntity` instance. Pass `null` for no initial data.

#### `CrewCredit($data = null)`

Create a new `CrewCreditEntity` instance. Pass `null` for no initial data.

#### `CrewMember($data = null)`

Create a new `CrewMemberEntity` instance. Pass `null` for no initial data.

#### `Episode($data = null)`

Create a new `EpisodeEntity` instance. Pass `null` for no initial data.

#### `GuestCastCredit($data = null)`

Create a new `GuestCastCreditEntity` instance. Pass `null` for no initial data.

#### `Image($data = null)`

Create a new `ImageEntity` instance. Pass `null` for no initial data.

#### `Person($data = null)`

Create a new `PersonEntity` instance. Pass `null` for no initial data.

#### `Schedule($data = null)`

Create a new `ScheduleEntity` instance. Pass `null` for no initial data.

#### `ScheduledEpisode($data = null)`

Create a new `ScheduledEpisodeEntity` instance. Pass `null` for no initial data.

#### `Search($data = null)`

Create a new `SearchEntity` instance. Pass `null` for no initial data.

#### `Season($data = null)`

Create a new `SeasonEntity` instance. Pass `null` for no initial data.

#### `Show($data = null)`

Create a new `ShowEntity` instance. Pass `null` for no initial data.

#### `Update($data = null)`

Create a new `UpdateEntity` instance. Pass `null` for no initial data.

#### `options_map(): array`

Return a deep copy of the current SDK options.

#### `get_utility(): TvmazeUtility`

Return a copy of the SDK utility object.

#### `direct(array $fetchargs = []): array`

Make a direct HTTP request to any API endpoint. This is the raw-HTTP escape
hatch: it does **not** throw. It returns a result array
`["ok" => bool, "status" => int, "headers" => array, "data" => mixed]`, or
`["ok" => false, "err" => \Exception]` on failure. Branch on `$result["ok"]`.

**Parameters:**

| Name | Type | Description |
| --- | --- | --- |
| `$fetchargs["path"]` | `string` | URL path with optional `{param}` placeholders. |
| `$fetchargs["method"]` | `string` | HTTP method (default: `"GET"`). |
| `$fetchargs["params"]` | `array` | Path parameter values for `{param}` substitution. |
| `$fetchargs["query"]` | `array` | Query string parameters. |
| `$fetchargs["headers"]` | `array` | Request headers (merged with defaults). |
| `$fetchargs["body"]` | `mixed` | Request body (arrays are JSON-serialized). |
| `$fetchargs["ctrl"]` | `array` | Control options. |

**Returns:** `array` — the result dict (see above); never throws.

#### `prepare(array $fetchargs = []): mixed`

Prepare a fetch definition without sending the request. Returns the
`$fetchdef` array. Throws on error.


---

## AkaEntity

```php
$aka = $client->Aka();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `country` | `array` | No |  |
| `name` | `string` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Aka()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): AkaEntity`

Create a new `AkaEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## AlternateListEntity

```php
$alternate_list = $client->AlternateList();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `int` | No |  |
| `link` | `array` | No |  |
| `name` | `string` | No |  |
| `url` | `string` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->AlternateList()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->AlternateList()->load(["id" => 1]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): AlternateListEntity`

Create a new `AlternateListEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## CastEntity

```php
$cast = $client->Cast();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `character` | `array` | No |  |
| `person` | `array` | No |  |
| `self` | `bool` | No |  |
| `voice` | `bool` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Cast()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): CastEntity`

Create a new `CastEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## CastCreditEntity

```php
$cast_credit = $client->CastCredit();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | `array` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->CastCredit()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): CastCreditEntity`

Create a new `CastCreditEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## CastMemberEntity

```php
$cast_member = $client->CastMember();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `character` | `array` | No |  |
| `person` | `array` | No |  |
| `self` | `bool` | No |  |
| `voice` | `bool` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->CastMember()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): CastMemberEntity`

Create a new `CastMemberEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## CrewEntity

```php
$crew = $client->Crew();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `person` | `array` | No |  |
| `type` | `string` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Crew()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): CrewEntity`

Create a new `CrewEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## CrewCreditEntity

```php
$crew_credit = $client->CrewCredit();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | `array` | No |  |
| `type` | `string` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->CrewCredit()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): CrewCreditEntity`

Create a new `CrewCreditEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## CrewMemberEntity

```php
$crew_member = $client->CrewMember();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `person` | `array` | No |  |
| `type` | `string` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->CrewMember()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): CrewMemberEntity`

Create a new `CrewMemberEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## EpisodeEntity

```php
$episode = $client->Episode();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `string` | No |  |
| `airstamp` | `string` | No |  |
| `airtime` | `string` | No |  |
| `id` | `int` | No |  |
| `image` | `array` | No |  |
| `link` | `array` | No |  |
| `name` | `string` | No |  |
| `number` | `int` | No |  |
| `rating` | `array` | No |  |
| `runtime` | `int` | No |  |
| `season` | `int` | No |  |
| `summary` | `string` | No |  |
| `type` | `string` | No |  |
| `url` | `string` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Episode()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Episode()->load(["id" => 1]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): EpisodeEntity`

Create a new `EpisodeEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## GuestCastCreditEntity

```php
$guest_cast_credit = $client->GuestCastCredit();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `link` | `array` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->GuestCastCredit()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): GuestCastCreditEntity`

Create a new `GuestCastCreditEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## ImageEntity

```php
$image = $client->Image();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `id` | `int` | No |  |
| `main` | `bool` | No |  |
| `resolution` | `array` | No |  |
| `type` | `string` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Image()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): ImageEntity`

Create a new `ImageEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## PersonEntity

```php
$person = $client->Person();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `birthday` | `string` | No |  |
| `country` | `array` | No |  |
| `deathday` | `string` | No |  |
| `gender` | `string` | No |  |
| `id` | `int` | No |  |
| `image` | `array` | No |  |
| `link` | `array` | No |  |
| `name` | `string` | No |  |
| `person` | `array` | No |  |
| `score` | `float` | No |  |
| `updated` | `int` | No |  |
| `url` | `string` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Person()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Person()->load(["id" => 1]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): PersonEntity`

Create a new `PersonEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## ScheduleEntity

```php
$schedule = $client->Schedule();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `string` | No |  |
| `airstamp` | `string` | No |  |
| `airtime` | `string` | No |  |
| `id` | `int` | No |  |
| `image` | `array` | No |  |
| `link` | `array` | No |  |
| `name` | `string` | No |  |
| `number` | `int` | No |  |
| `rating` | `array` | No |  |
| `runtime` | `int` | No |  |
| `season` | `int` | No |  |
| `show` | `array` | No |  |
| `summary` | `string` | No |  |
| `type` | `string` | No |  |
| `url` | `string` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Schedule()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): ScheduleEntity`

Create a new `ScheduleEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## ScheduledEpisodeEntity

```php
$scheduled_episode = $client->ScheduledEpisode();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `airdate` | `string` | No |  |
| `airstamp` | `string` | No |  |
| `airtime` | `string` | No |  |
| `id` | `int` | No |  |
| `image` | `array` | No |  |
| `link` | `array` | No |  |
| `name` | `string` | No |  |
| `number` | `int` | No |  |
| `rating` | `array` | No |  |
| `runtime` | `int` | No |  |
| `season` | `int` | No |  |
| `show` | `array` | No |  |
| `summary` | `string` | No |  |
| `type` | `string` | No |  |
| `url` | `string` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->ScheduledEpisode()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): ScheduledEpisodeEntity`

Create a new `ScheduledEpisodeEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## SearchEntity

```php
$search = $client->Search();
```

### Operations

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Search()->load();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): SearchEntity`

Create a new `SearchEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## SeasonEntity

```php
$season = $client->Season();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `end_date` | `string` | No |  |
| `episode_order` | `int` | No |  |
| `id` | `int` | No |  |
| `image` | `array` | No |  |
| `link` | `array` | No |  |
| `name` | `string` | No |  |
| `network` | `array` | No |  |
| `number` | `int` | No |  |
| `premiere_date` | `string` | No |  |
| `summary` | `string` | No |  |
| `url` | `string` | No |  |
| `web_channel` | `array` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Season()->list();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): SeasonEntity`

Create a new `SeasonEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## ShowEntity

```php
$show = $client->Show();
```

### Fields

| Field | Type | Required | Description |
| --- | --- | --- | --- |
| `average_runtime` | `int` | No |  |
| `dvd_country` | `array` | No |  |
| `ended` | `string` | No |  |
| `external` | `array` | No |  |
| `genre` | `array` | No |  |
| `id` | `int` | No |  |
| `image` | `array` | No |  |
| `language` | `string` | No |  |
| `link` | `array` | No |  |
| `name` | `string` | No |  |
| `network` | `array` | No |  |
| `official_site` | `string` | No |  |
| `premiered` | `string` | No |  |
| `rating` | `array` | No |  |
| `runtime` | `int` | No |  |
| `schedule` | `array` | No |  |
| `score` | `float` | No |  |
| `show` | `array` | No |  |
| `status` | `string` | No |  |
| `summary` | `string` | No |  |
| `type` | `string` | No |  |
| `updated` | `int` | No |  |
| `url` | `string` | No |  |
| `web_channel` | `array` | No |  |
| `weight` | `int` | No |  |

### Operations

#### `list(?array $reqmatch = null, ?array $ctrl = null): mixed`

List entities matching the given criteria (call with no argument to list all). Returns an array. Throws on error.

```php
$results = $client->Show()->list();
```

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Show()->load(["id" => 1]);
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): ShowEntity`

Create a new `ShowEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## UpdateEntity

```php
$update = $client->Update();
```

### Operations

#### `load(array $reqmatch, ?array $ctrl = null): mixed`

Load a single entity matching the given criteria. Throws on error.

```php
$result = $client->Update()->load();
```

### Common Methods

#### `data_get(): array`

Get the entity data. Returns a copy of the current data.

#### `data_set($data): void`

Set the entity data.

#### `match_get(): array`

Get the entity match criteria.

#### `match_set($match): void`

Set the entity match criteria.

#### `make(): UpdateEntity`

Create a new `UpdateEntity` instance with the same client and
options.

#### `get_name(): string`

Return the entity name.


---

## Features

| Feature | Version | Description |
| --- | --- | --- |
| `test` | 0.0.1 | In-memory mock transport for testing without a live server |


Features are activated via the `feature` option:

```php
$client = new TvmazeSDK([
  "feature" => [
    "test" => ["active" => true],
  ],
]);
```

