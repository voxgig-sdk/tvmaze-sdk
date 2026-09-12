<?php
declare(strict_types=1);

// Tvmaze SDK configuration

class TvmazeConfig
{
    /** @var array<string,mixed>|null */
    private static ?array $shared_config = null;

    /**
     * Return the process-wide config, built once on first use. The SDK reads
     * the config on every request and never writes to it, so one instance is
     * shared by every client rather than rebuilt per client.
     *
     * PHP arrays are copy-on-write, so callers that do mutate the result get
     * their own copy and cannot disturb the shared one.
     */
    public static function shared_config(): array
    {
        if (self::$shared_config === null) {
            self::$shared_config = self::make_config();
        }
        return self::$shared_config;
    }

    /**
     * Build a fresh, fully materialised config array. Every call rebuilds the
     * whole structure, so prefer shared_config unless you need a private copy.
     */
    public static function make_config(): array
    {
        return [
            "main" => [
                "name" => "Tvmaze",
                "slug" => "tvmaze",
                "version" => "0.0.1",
                "target" => "php",
            ],
            "feature" => [
                "test" => [
          'options' => [
            'active' => false,
          ],
          'transport' => 'base',
        ],
            ],
            "options" => [
                "base" => "https://api.tvmaze.com",
                "headers" => [
          'content-type' => 'application/json',
        ],
                "entity" => [
                    "aka" => [],
                    "alternate_list" => [],
                    "cast" => [],
                    "cast_credit" => [],
                    "cast_member" => [],
                    "crew" => [],
                    "crew_credit" => [],
                    "crew_member" => [],
                    "episode" => [],
                    "guest_cast_credit" => [],
                    "image" => [],
                    "person" => [],
                    "schedule" => [],
                    "scheduled_episode" => [],
                    "search" => [],
                    "season" => [],
                    "show" => [],
                    "update" => [],
                ],
            ],
            "entity" => [
        'aka' => [
          'fields' => [
            [
              'name' => 'country',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'name',
              'short' => 'Alternate name',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'aka',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'show_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/shows/{id}/akas',
                  'rename' => [
                    'param' => [
                      'id' => 'show_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'shows',
                    ],
                    [
                      'var' => 'show_id',
                    ],
                    [
                      'lit' => 'akas',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'show_id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'shows',
                    '{show_id}',
                    'akas',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'show',
              ],
            ],
          ],
        ],
        'alternate_list' => [
          'fields' => [
            [
              'name' => 'id',
              'short' => 'Unique alternate list identifier',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'links',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'name',
              'short' => 'Name of alternate list (e.g., DVD Order)',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'self',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'url',
              'short' => 'TVmaze URL for the alternate list',
              'type' => '`$STRING`',
            ],
          ],
          'id' => [
            'field' => 'id',
            'name' => 'id',
          ],
          'name' => 'alternate_list',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'show_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/shows/{id}/alternatelists',
                  'rename' => [
                    'param' => [
                      'id' => 'show_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'shows',
                    ],
                    [
                      'var' => 'show_id',
                    ],
                    [
                      'lit' => 'alternatelists',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'show_id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'shows',
                    '{show_id}',
                    'alternatelists',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'embed',
                        'orig' => 'embed',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/alternatelists/{id}',
                  'segments' => [
                    [
                      'lit' => 'alternatelists',
                    ],
                    [
                      'var' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'embed',
                      'id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body._links`',
                  ],
                  'parts' => [
                    'alternatelists',
                    '{id}',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'show',
              ],
            ],
          ],
        ],
        'cast' => [
          'fields' => [
            [
              'name' => 'character',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'person',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'self',
              'short' => 'Whether person plays themselves',
              'type' => '`$BOOLEAN`',
            ],
            [
              'name' => 'voice',
              'short' => 'Whether this is a voice role',
              'type' => '`$BOOLEAN`',
            ],
          ],
          'name' => 'cast',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'show_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/shows/{id}/cast',
                  'rename' => [
                    'param' => [
                      'id' => 'show_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'shows',
                    ],
                    [
                      'var' => 'show_id',
                    ],
                    [
                      'lit' => 'cast',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'show_id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'shows',
                    '{show_id}',
                    'cast',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'show',
              ],
            ],
          ],
        ],
        'cast_credit' => [
          'fields' => [
            [
              'name' => 'links',
              'type' => '`$OBJECT`',
            ],
          ],
          'name' => 'cast_credit',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'person_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'embed',
                        'orig' => 'embed',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/people/{id}/castcredits',
                  'rename' => [
                    'param' => [
                      'id' => 'person_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'people',
                    ],
                    [
                      'var' => 'person_id',
                    ],
                    [
                      'lit' => 'castcredits',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'embed',
                      'person_id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'people',
                    '{person_id}',
                    'castcredits',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'person',
              ],
            ],
          ],
        ],
        'cast_member' => [
          'fields' => [
            [
              'name' => 'character',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'person',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'self',
              'short' => 'Whether person plays themselves',
              'type' => '`$BOOLEAN`',
            ],
            [
              'name' => 'voice',
              'short' => 'Whether this is a voice role',
              'type' => '`$BOOLEAN`',
            ],
          ],
          'name' => 'cast_member',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'episode_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/episodes/{id}/guestcast',
                  'rename' => [
                    'param' => [
                      'id' => 'episode_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'episodes',
                    ],
                    [
                      'var' => 'episode_id',
                    ],
                    [
                      'lit' => 'guestcast',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'episode_id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'episodes',
                    '{episode_id}',
                    'guestcast',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'episode',
              ],
            ],
          ],
        ],
        'crew' => [
          'fields' => [
            [
              'name' => 'person',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'type',
              'short' => 'Crew type (e.g., Executive Producer)',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'crew',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'show_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/shows/{id}/crew',
                  'rename' => [
                    'param' => [
                      'id' => 'show_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'shows',
                    ],
                    [
                      'var' => 'show_id',
                    ],
                    [
                      'lit' => 'crew',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'show_id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'shows',
                    '{show_id}',
                    'crew',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'show',
              ],
            ],
          ],
        ],
        'crew_credit' => [
          'fields' => [
            [
              'name' => 'links',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'type',
              'short' => 'Crew type',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'crew_credit',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'person_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'embed',
                        'orig' => 'embed',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/people/{id}/crewcredits',
                  'rename' => [
                    'param' => [
                      'id' => 'person_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'people',
                    ],
                    [
                      'var' => 'person_id',
                    ],
                    [
                      'lit' => 'crewcredits',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'embed',
                      'person_id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'people',
                    '{person_id}',
                    'crewcredits',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'person',
              ],
            ],
          ],
        ],
        'crew_member' => [
          'fields' => [
            [
              'name' => 'person',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'type',
              'short' => 'Crew type (e.g., Executive Producer)',
              'type' => '`$STRING`',
            ],
          ],
          'name' => 'crew_member',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'episode_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/episodes/{id}/guestcrew',
                  'rename' => [
                    'param' => [
                      'id' => 'episode_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'episodes',
                    ],
                    [
                      'var' => 'episode_id',
                    ],
                    [
                      'lit' => 'guestcrew',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'episode_id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'episodes',
                    '{episode_id}',
                    'guestcrew',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'episode',
              ],
            ],
          ],
        ],
        'episode' => [
          'fields' => [
            [
              'format' => 'date',
              'name' => 'airdate',
              'short' => 'Air date',
              'type' => '`$STRING`',
            ],
            [
              'format' => 'date-time',
              'name' => 'airstamp',
              'short' => 'Air timestamp',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'airtime',
              'short' => 'Air time',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'short' => 'Unique episode identifier',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'image',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'links',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'name',
              'short' => 'Episode name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'number',
              'short' => 'Episode number in season',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'rating',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'runtime',
              'short' => 'Runtime in minutes',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'season',
              'short' => 'Season number',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'summary',
              'short' => 'HTML summary',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'type',
              'short' => 'Episode type (e.g., regular, significant_special)',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'url',
              'short' => 'TVmaze URL for the episode',
              'type' => '`$STRING`',
            ],
          ],
          'id' => [
            'field' => 'id',
            'name' => 'id',
          ],
          'name' => 'episode',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'show_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'date',
                        'orig' => 'date',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/shows/{id}/episodesbydate',
                  'rename' => [
                    'param' => [
                      'id' => 'show_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'shows',
                    ],
                    [
                      'var' => 'show_id',
                    ],
                    [
                      'lit' => 'episodesbydate',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'date',
                      'show_id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'shows',
                    '{show_id}',
                    'episodesbydate',
                  ],
                ],
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'season_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'embed',
                        'orig' => 'embed',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/seasons/{id}/episodes',
                  'rename' => [
                    'param' => [
                      'id' => 'season_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'seasons',
                    ],
                    [
                      'var' => 'season_id',
                    ],
                    [
                      'lit' => 'episodes',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'embed',
                      'season_id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'seasons',
                    '{season_id}',
                    'episodes',
                  ],
                ],
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'show_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'special',
                        'orig' => 'special',
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/shows/{id}/episodes',
                  'rename' => [
                    'param' => [
                      'id' => 'show_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'shows',
                    ],
                    [
                      'var' => 'show_id',
                    ],
                    [
                      'lit' => 'episodes',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'show_id',
                      'special',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'shows',
                    '{show_id}',
                    'episodes',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'show_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'number',
                        'orig' => 'number',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'season',
                        'orig' => 'season',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/shows/{id}/episodebynumber',
                  'rename' => [
                    'param' => [
                      'id' => 'show_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'shows',
                    ],
                    [
                      'var' => 'show_id',
                    ],
                    [
                      'lit' => 'episodebynumber',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'number',
                      'season',
                      'show_id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'shows',
                    '{show_id}',
                    'episodebynumber',
                  ],
                ],
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'embed',
                        'orig' => 'embed',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/episodes/{id}',
                  'segments' => [
                    [
                      'lit' => 'episodes',
                    ],
                    [
                      'var' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'embed',
                      'id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'episodes',
                    '{id}',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'season',
              ],
              [
                'show',
              ],
            ],
          ],
        ],
        'guest_cast_credit' => [
          'fields' => [
            [
              'name' => 'links',
              'type' => '`$OBJECT`',
            ],
          ],
          'name' => 'guest_cast_credit',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'person_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'embed',
                        'orig' => 'embed',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/people/{id}/guestcastcredits',
                  'rename' => [
                    'param' => [
                      'id' => 'person_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'people',
                    ],
                    [
                      'var' => 'person_id',
                    ],
                    [
                      'lit' => 'guestcastcredits',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'embed',
                      'person_id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'people',
                    '{person_id}',
                    'guestcastcredits',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'person',
              ],
            ],
          ],
        ],
        'image' => [
          'fields' => [
            [
              'name' => 'id',
              'short' => 'Unique image identifier',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'main',
              'short' => 'Whether this is the main image',
              'type' => '`$BOOLEAN`',
            ],
            [
              'name' => 'resolutions',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'type',
              'short' => 'Image type',
              'type' => '`$STRING`',
            ],
          ],
          'id' => [
            'field' => 'id',
            'name' => 'id',
          ],
          'name' => 'image',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'show_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/shows/{id}/images',
                  'rename' => [
                    'param' => [
                      'id' => 'show_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'shows',
                    ],
                    [
                      'var' => 'show_id',
                    ],
                    [
                      'lit' => 'images',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'show_id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'shows',
                    '{show_id}',
                    'images',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'show',
              ],
            ],
          ],
        ],
        'person' => [
          'fields' => [
            [
              'format' => 'date',
              'name' => 'birthday',
              'short' => 'Birth date',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'country',
              'type' => '`$OBJECT`',
            ],
            [
              'format' => 'date',
              'name' => 'deathday',
              'short' => 'Death date',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'gender',
              'short' => 'Gender',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'short' => 'Unique person identifier',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'image',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'links',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'name',
              'short' => 'Person name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'person',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'score',
              'short' => 'Search relevancy score',
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'updated',
              'short' => 'Unix timestamp of last update',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'url',
              'short' => 'TVmaze URL for the person',
              'type' => '`$STRING`',
            ],
          ],
          'id' => [
            'field' => 'id',
            'name' => 'id',
          ],
          'name' => 'person',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'page',
                        'orig' => 'page',
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/people',
                  'segments' => [
                    [
                      'lit' => 'people',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'page',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'people',
                  ],
                ],
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'q',
                        'orig' => 'q',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/search/people',
                  'segments' => [
                    [
                      'lit' => 'search',
                    ],
                    [
                      'lit' => 'people',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'q',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'search',
                    'people',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'embed',
                        'orig' => 'embed',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/people/{id}',
                  'segments' => [
                    [
                      'lit' => 'people',
                    ],
                    [
                      'var' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'embed',
                      'id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'people',
                    '{id}',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'schedule' => [
          'fields' => [
            [
              'format' => 'date',
              'name' => 'airdate',
              'short' => 'Air date',
              'type' => '`$STRING`',
            ],
            [
              'format' => 'date-time',
              'name' => 'airstamp',
              'short' => 'Air timestamp',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'airtime',
              'short' => 'Air time',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'short' => 'Unique episode identifier',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'image',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'links',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'name',
              'short' => 'Episode name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'number',
              'short' => 'Episode number in season',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'rating',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'runtime',
              'short' => 'Runtime in minutes',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'season',
              'short' => 'Season number',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'show',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'summary',
              'short' => 'HTML summary',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'type',
              'short' => 'Episode type (e.g., regular, significant_special)',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'url',
              'short' => 'TVmaze URL for the episode',
              'type' => '`$STRING`',
            ],
          ],
          'id' => [
            'field' => 'id',
            'name' => 'id',
          ],
          'name' => 'schedule',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'example' => 'US',
                        'kind' => 'query',
                        'name' => 'country',
                        'orig' => 'country',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'date',
                        'orig' => 'date',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/schedule',
                  'segments' => [
                    [
                      'lit' => 'schedule',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'country',
                      'date',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'schedule',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'scheduled_episode' => [
          'fields' => [
            [
              'format' => 'date',
              'name' => 'airdate',
              'short' => 'Air date',
              'type' => '`$STRING`',
            ],
            [
              'format' => 'date-time',
              'name' => 'airstamp',
              'short' => 'Air timestamp',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'airtime',
              'short' => 'Air time',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'id',
              'short' => 'Unique episode identifier',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'image',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'links',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'name',
              'short' => 'Episode name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'number',
              'short' => 'Episode number in season',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'rating',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'runtime',
              'short' => 'Runtime in minutes',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'season',
              'short' => 'Season number',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'show',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'summary',
              'short' => 'HTML summary',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'type',
              'short' => 'Episode type (e.g., regular, significant_special)',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'url',
              'short' => 'TVmaze URL for the episode',
              'type' => '`$STRING`',
            ],
          ],
          'id' => [
            'field' => 'id',
            'name' => 'id',
          ],
          'name' => 'scheduled_episode',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'country',
                        'orig' => 'country',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'date',
                        'orig' => 'date',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/schedule/web',
                  'segments' => [
                    [
                      'lit' => 'schedule',
                    ],
                    [
                      'lit' => 'web',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'country',
                      'date',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'schedule',
                    'web',
                  ],
                ],
                [
                  'args' => [],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/schedule/full',
                  'segments' => [
                    [
                      'lit' => 'schedule',
                    ],
                    [
                      'lit' => 'full',
                    ],
                  ],
                  'select' => [],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'schedule',
                    'full',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'search' => [
          'fields' => [],
          'name' => 'search',
          'op' => [
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'imdb',
                        'orig' => 'imdb',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'thetvdb',
                        'orig' => 'thetvdb',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'tvrage',
                        'orig' => 'tvrage',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/lookup/shows',
                  'segments' => [
                    [
                      'lit' => 'lookup',
                    ],
                    [
                      'lit' => 'shows',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'imdb',
                      'thetvdb',
                      'tvrage',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'lookup',
                    'shows',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
        'season' => [
          'fields' => [
            [
              'format' => 'date',
              'name' => 'endDate',
              'short' => 'End date',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'episodeOrder',
              'short' => 'Number of episodes',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'id',
              'short' => 'Unique season identifier',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'image',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'links',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'name',
              'short' => 'Season name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'network',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'number',
              'short' => 'Season number',
              'type' => '`$INTEGER`',
            ],
            [
              'format' => 'date',
              'name' => 'premiereDate',
              'short' => 'Premiere date',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'summary',
              'short' => 'HTML summary',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'url',
              'short' => 'TVmaze URL for the season',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'webChannel',
              'type' => '`$OBJECT`',
            ],
          ],
          'id' => [
            'field' => 'id',
            'name' => 'id',
          ],
          'name' => 'season',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'show_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/shows/{id}/seasons',
                  'rename' => [
                    'param' => [
                      'id' => 'show_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'shows',
                    ],
                    [
                      'var' => 'show_id',
                    ],
                    [
                      'lit' => 'seasons',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'show_id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'shows',
                    '{show_id}',
                    'seasons',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'show',
              ],
            ],
          ],
        ],
        'show' => [
          'fields' => [
            [
              'name' => 'averageRuntime',
              'short' => 'Average runtime in minutes',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'dvdCountry',
              'type' => '`$OBJECT`',
            ],
            [
              'format' => 'date',
              'name' => 'ended',
              'short' => 'End date',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'externals',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'genres',
              'short' => 'List of genres',
              'type' => '`$ARRAY`',
            ],
            [
              'name' => 'id',
              'short' => 'Unique show identifier',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'image',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'language',
              'short' => 'Original language',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'links',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'name',
              'short' => 'Show name',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'network',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'officialSite',
              'short' => 'Official website URL',
              'type' => '`$STRING`',
            ],
            [
              'format' => 'date',
              'name' => 'premiered',
              'short' => 'Premiere date',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'rating',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'runtime',
              'short' => 'Runtime in minutes',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'schedule',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'score',
              'short' => 'Search relevancy score',
              'type' => '`$NUMBER`',
            ],
            [
              'name' => 'show',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'status',
              'short' => 'Current status (e.g., Running, Ended)',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'summary',
              'short' => 'HTML summary',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'type',
              'short' => 'Show type (e.g., Scripted, Reality)',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'updated',
              'short' => 'Unix timestamp of last update',
              'type' => '`$INTEGER`',
            ],
            [
              'name' => 'url',
              'short' => 'TVmaze URL for the show',
              'type' => '`$STRING`',
            ],
            [
              'name' => 'webChannel',
              'type' => '`$OBJECT`',
            ],
            [
              'name' => 'weight',
              'short' => 'Show weight/importance',
              'type' => '`$INTEGER`',
            ],
          ],
          'id' => [
            'field' => 'id',
            'name' => 'id',
          ],
          'name' => 'show',
          'op' => [
            'list' => [
              'input' => 'data',
              'name' => 'list',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'alternatelist_id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'embed',
                        'orig' => 'embed',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/alternatelists/{id}/alternateepisodes',
                  'rename' => [
                    'param' => [
                      'id' => 'alternatelist_id',
                    ],
                  ],
                  'segments' => [
                    [
                      'lit' => 'alternatelists',
                    ],
                    [
                      'var' => 'alternatelist_id',
                    ],
                    [
                      'lit' => 'alternateepisodes',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'alternatelist_id',
                      'embed',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'alternatelists',
                    '{alternatelist_id}',
                    'alternateepisodes',
                  ],
                ],
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'embed',
                        'orig' => 'embed',
                        'type' => '`$STRING`',
                      ],
                      [
                        'kind' => 'query',
                        'name' => 'q',
                        'orig' => 'q',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/singlesearch/shows',
                  'segments' => [
                    [
                      'lit' => 'singlesearch',
                    ],
                    [
                      'lit' => 'shows',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'embed',
                      'q',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'singlesearch',
                    'shows',
                  ],
                ],
                [
                  'args' => [
                    'query' => [
                      [
                        'example' => 0,
                        'kind' => 'query',
                        'name' => 'page',
                        'orig' => 'page',
                        'type' => '`$INTEGER`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/shows',
                  'segments' => [
                    [
                      'lit' => 'shows',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'page',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'shows',
                  ],
                ],
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'q',
                        'orig' => 'q',
                        'reqd' => true,
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/search/shows',
                  'segments' => [
                    [
                      'lit' => 'search',
                    ],
                    [
                      'lit' => 'shows',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'q',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'search',
                    'shows',
                  ],
                ],
              ],
            ],
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'params' => [
                      [
                        'kind' => 'param',
                        'name' => 'id',
                        'orig' => 'id',
                        'reqd' => true,
                        'type' => '`$INTEGER`',
                      ],
                    ],
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'embed',
                        'orig' => 'embed',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/shows/{id}',
                  'segments' => [
                    [
                      'lit' => 'shows',
                    ],
                    [
                      'var' => 'id',
                    ],
                  ],
                  'select' => [
                    'exist' => [
                      'embed',
                      'id',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'shows',
                    '{id}',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [
              [
                'alternatelist',
              ],
            ],
          ],
        ],
        'update' => [
          'fields' => [],
          'name' => 'update',
          'op' => [
            'load' => [
              'input' => 'data',
              'name' => 'load',
              'points' => [
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'since',
                        'orig' => 'since',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/updates/people',
                  'segments' => [
                    [
                      'lit' => 'updates',
                    ],
                    [
                      'lit' => 'people',
                    ],
                  ],
                  'select' => [
                    '$action' => 'person',
                    'exist' => [
                      'since',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'updates',
                    'people',
                  ],
                ],
                [
                  'args' => [
                    'query' => [
                      [
                        'kind' => 'query',
                        'name' => 'since',
                        'orig' => 'since',
                        'type' => '`$STRING`',
                      ],
                    ],
                  ],
                  'kind' => 'http',
                  'method' => 'GET',
                  'orig' => '/updates/shows',
                  'segments' => [
                    [
                      'lit' => 'updates',
                    ],
                    [
                      'lit' => 'shows',
                    ],
                  ],
                  'select' => [
                    '$action' => 'show',
                    'exist' => [
                      'since',
                    ],
                  ],
                  'transform' => [
                    'req' => '`reqdata`',
                    'res' => '`body`',
                  ],
                  'parts' => [
                    'updates',
                    'shows',
                  ],
                ],
              ],
            ],
          ],
          'relations' => [
            'ancestors' => [],
          ],
        ],
      ],
        ];
    }


    public static function make_feature(string $name)
    {
        require_once __DIR__ . '/features.php';
        return TvmazeFeatures::make_feature($name);
    }
}
