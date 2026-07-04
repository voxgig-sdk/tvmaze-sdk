# Tvmaze SDK configuration

module TvmazeConfig
  def self.make_config
    {
      "main" => {
        "name" => "Tvmaze",
      },
      "feature" => {
        "test" => {
          "options" => {
            "active" => false,
          },
        },
      },
      "options" => {
        "base" => "https://api.tvmaze.com",
        "headers" => {
          "content-type" => "application/json",
        },
        "entity" => {
          "aka" => {},
          "alternate_list" => {},
          "cast" => {},
          "cast_credit" => {},
          "cast_member" => {},
          "crew" => {},
          "crew_credit" => {},
          "crew_member" => {},
          "episode" => {},
          "guest_cast_credit" => {},
          "image" => {},
          "person" => {},
          "schedule" => {},
          "scheduled_episode" => {},
          "search" => {},
          "season" => {},
          "show" => {},
          "update" => {},
        },
      },
      "entity" => {
        "aka" => {
          "fields" => [
            {
              "active" => true,
              "name" => "country",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "name",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 1,
            },
          ],
          "name" => "aka",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "show_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/shows/{id}/akas",
                  "parts" => [
                    "shows",
                    "{show_id}",
                    "akas",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "show_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "show_id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "list",
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "show",
              ],
            ],
          },
        },
        "alternate_list" => {
          "fields" => [
            {
              "active" => true,
              "name" => "id",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "link",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 1,
            },
            {
              "active" => true,
              "name" => "name",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 2,
            },
            {
              "active" => true,
              "name" => "url",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 3,
            },
          ],
          "name" => "alternate_list",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "show_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/shows/{id}/alternatelists",
                  "parts" => [
                    "shows",
                    "{show_id}",
                    "alternatelists",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "show_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "show_id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "list",
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "embed",
                        "orig" => "embed",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/alternatelists/{id}",
                  "parts" => [
                    "alternatelists",
                    "{id}",
                  ],
                  "select" => {
                    "exist" => [
                      "embed",
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "load",
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "show",
              ],
            ],
          },
        },
        "cast" => {
          "fields" => [
            {
              "active" => true,
              "name" => "character",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "person",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 1,
            },
            {
              "active" => true,
              "name" => "self",
              "req" => false,
              "type" => "`$BOOLEAN`",
              "index$" => 2,
            },
            {
              "active" => true,
              "name" => "voice",
              "req" => false,
              "type" => "`$BOOLEAN`",
              "index$" => 3,
            },
          ],
          "name" => "cast",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "show_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/shows/{id}/cast",
                  "parts" => [
                    "shows",
                    "{show_id}",
                    "cast",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "show_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "show_id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "list",
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "show",
              ],
            ],
          },
        },
        "cast_credit" => {
          "fields" => [
            {
              "active" => true,
              "name" => "link",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 0,
            },
          ],
          "name" => "cast_credit",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "person_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "embed",
                        "orig" => "embed",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/people/{id}/castcredits",
                  "parts" => [
                    "people",
                    "{person_id}",
                    "castcredits",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "person_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "embed",
                      "person_id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "list",
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "person",
              ],
            ],
          },
        },
        "cast_member" => {
          "fields" => [
            {
              "active" => true,
              "name" => "character",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "person",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 1,
            },
            {
              "active" => true,
              "name" => "self",
              "req" => false,
              "type" => "`$BOOLEAN`",
              "index$" => 2,
            },
            {
              "active" => true,
              "name" => "voice",
              "req" => false,
              "type" => "`$BOOLEAN`",
              "index$" => 3,
            },
          ],
          "name" => "cast_member",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "episode_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/episodes/{id}/guestcast",
                  "parts" => [
                    "episodes",
                    "{episode_id}",
                    "guestcast",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "episode_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "episode_id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "list",
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "episode",
              ],
            ],
          },
        },
        "crew" => {
          "fields" => [
            {
              "active" => true,
              "name" => "person",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "type",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 1,
            },
          ],
          "name" => "crew",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "show_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/shows/{id}/crew",
                  "parts" => [
                    "shows",
                    "{show_id}",
                    "crew",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "show_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "show_id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "list",
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "show",
              ],
            ],
          },
        },
        "crew_credit" => {
          "fields" => [
            {
              "active" => true,
              "name" => "link",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "type",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 1,
            },
          ],
          "name" => "crew_credit",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "person_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "embed",
                        "orig" => "embed",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/people/{id}/crewcredits",
                  "parts" => [
                    "people",
                    "{person_id}",
                    "crewcredits",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "person_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "embed",
                      "person_id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "list",
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "person",
              ],
            ],
          },
        },
        "crew_member" => {
          "fields" => [
            {
              "active" => true,
              "name" => "person",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "type",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 1,
            },
          ],
          "name" => "crew_member",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "episode_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/episodes/{id}/guestcrew",
                  "parts" => [
                    "episodes",
                    "{episode_id}",
                    "guestcrew",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "episode_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "episode_id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "list",
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "episode",
              ],
            ],
          },
        },
        "episode" => {
          "fields" => [
            {
              "active" => true,
              "name" => "airdate",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "airstamp",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 1,
            },
            {
              "active" => true,
              "name" => "airtime",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 2,
            },
            {
              "active" => true,
              "name" => "id",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 3,
            },
            {
              "active" => true,
              "name" => "image",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 4,
            },
            {
              "active" => true,
              "name" => "link",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 5,
            },
            {
              "active" => true,
              "name" => "name",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 6,
            },
            {
              "active" => true,
              "name" => "number",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 7,
            },
            {
              "active" => true,
              "name" => "rating",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 8,
            },
            {
              "active" => true,
              "name" => "runtime",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 9,
            },
            {
              "active" => true,
              "name" => "season",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 10,
            },
            {
              "active" => true,
              "name" => "summary",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 11,
            },
            {
              "active" => true,
              "name" => "type",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 12,
            },
            {
              "active" => true,
              "name" => "url",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 13,
            },
          ],
          "name" => "episode",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "show_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "date",
                        "orig" => "date",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/shows/{id}/episodesbydate",
                  "parts" => [
                    "shows",
                    "{show_id}",
                    "episodesbydate",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "show_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "date",
                      "show_id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "season_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "embed",
                        "orig" => "embed",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/seasons/{id}/episodes",
                  "parts" => [
                    "seasons",
                    "{season_id}",
                    "episodes",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "season_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "embed",
                      "season_id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 1,
                },
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "show_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "special",
                        "orig" => "special",
                        "reqd" => false,
                        "type" => "`$INTEGER`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/shows/{id}/episodes",
                  "parts" => [
                    "shows",
                    "{show_id}",
                    "episodes",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "show_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "show_id",
                      "special",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 2,
                },
              ],
              "key$" => "list",
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "show_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "number",
                        "orig" => "number",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                      },
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "season",
                        "orig" => "season",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/shows/{id}/episodebynumber",
                  "parts" => [
                    "shows",
                    "{show_id}",
                    "episodebynumber",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "show_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "number",
                      "season",
                      "show_id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "embed",
                        "orig" => "embed",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/episodes/{id}",
                  "parts" => [
                    "episodes",
                    "{id}",
                  ],
                  "select" => {
                    "exist" => [
                      "embed",
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 1,
                },
              ],
              "key$" => "load",
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "season",
              ],
              [
                "show",
              ],
            ],
          },
        },
        "guest_cast_credit" => {
          "fields" => [
            {
              "active" => true,
              "name" => "link",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 0,
            },
          ],
          "name" => "guest_cast_credit",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "person_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "embed",
                        "orig" => "embed",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/people/{id}/guestcastcredits",
                  "parts" => [
                    "people",
                    "{person_id}",
                    "guestcastcredits",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "person_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "embed",
                      "person_id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "list",
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "person",
              ],
            ],
          },
        },
        "image" => {
          "fields" => [
            {
              "active" => true,
              "name" => "id",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "main",
              "req" => false,
              "type" => "`$BOOLEAN`",
              "index$" => 1,
            },
            {
              "active" => true,
              "name" => "resolution",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 2,
            },
            {
              "active" => true,
              "name" => "type",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 3,
            },
          ],
          "name" => "image",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "show_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/shows/{id}/images",
                  "parts" => [
                    "shows",
                    "{show_id}",
                    "images",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "show_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "show_id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "list",
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "show",
              ],
            ],
          },
        },
        "person" => {
          "fields" => [
            {
              "active" => true,
              "name" => "birthday",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "country",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 1,
            },
            {
              "active" => true,
              "name" => "deathday",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 2,
            },
            {
              "active" => true,
              "name" => "gender",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 3,
            },
            {
              "active" => true,
              "name" => "id",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 4,
            },
            {
              "active" => true,
              "name" => "image",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 5,
            },
            {
              "active" => true,
              "name" => "link",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 6,
            },
            {
              "active" => true,
              "name" => "name",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 7,
            },
            {
              "active" => true,
              "name" => "person",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 8,
            },
            {
              "active" => true,
              "name" => "score",
              "req" => false,
              "type" => "`$NUMBER`",
              "index$" => 9,
            },
            {
              "active" => true,
              "name" => "updated",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 10,
            },
            {
              "active" => true,
              "name" => "url",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 11,
            },
          ],
          "name" => "person",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "query" => [
                      {
                        "active" => true,
                        "example" => 0,
                        "kind" => "query",
                        "name" => "page",
                        "orig" => "page",
                        "reqd" => false,
                        "type" => "`$INTEGER`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/people",
                  "parts" => [
                    "people",
                  ],
                  "select" => {
                    "exist" => [
                      "page",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
                {
                  "active" => true,
                  "args" => {
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "q",
                        "orig" => "q",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/search/people",
                  "parts" => [
                    "search",
                    "people",
                  ],
                  "select" => {
                    "exist" => [
                      "q",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 1,
                },
              ],
              "key$" => "list",
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "embed",
                        "orig" => "embed",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/people/{id}",
                  "parts" => [
                    "people",
                    "{id}",
                  ],
                  "select" => {
                    "exist" => [
                      "embed",
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "load",
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "schedule" => {
          "fields" => [
            {
              "active" => true,
              "name" => "airdate",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "airstamp",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 1,
            },
            {
              "active" => true,
              "name" => "airtime",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 2,
            },
            {
              "active" => true,
              "name" => "id",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 3,
            },
            {
              "active" => true,
              "name" => "image",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 4,
            },
            {
              "active" => true,
              "name" => "link",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 5,
            },
            {
              "active" => true,
              "name" => "name",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 6,
            },
            {
              "active" => true,
              "name" => "number",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 7,
            },
            {
              "active" => true,
              "name" => "rating",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 8,
            },
            {
              "active" => true,
              "name" => "runtime",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 9,
            },
            {
              "active" => true,
              "name" => "season",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 10,
            },
            {
              "active" => true,
              "name" => "show",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 11,
            },
            {
              "active" => true,
              "name" => "summary",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 12,
            },
            {
              "active" => true,
              "name" => "type",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 13,
            },
            {
              "active" => true,
              "name" => "url",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 14,
            },
          ],
          "name" => "schedule",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "query" => [
                      {
                        "active" => true,
                        "example" => "US",
                        "kind" => "query",
                        "name" => "country",
                        "orig" => "country",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "date",
                        "orig" => "date",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/schedule",
                  "parts" => [
                    "schedule",
                  ],
                  "select" => {
                    "exist" => [
                      "country",
                      "date",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "list",
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "scheduled_episode" => {
          "fields" => [
            {
              "active" => true,
              "name" => "airdate",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "airstamp",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 1,
            },
            {
              "active" => true,
              "name" => "airtime",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 2,
            },
            {
              "active" => true,
              "name" => "id",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 3,
            },
            {
              "active" => true,
              "name" => "image",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 4,
            },
            {
              "active" => true,
              "name" => "link",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 5,
            },
            {
              "active" => true,
              "name" => "name",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 6,
            },
            {
              "active" => true,
              "name" => "number",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 7,
            },
            {
              "active" => true,
              "name" => "rating",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 8,
            },
            {
              "active" => true,
              "name" => "runtime",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 9,
            },
            {
              "active" => true,
              "name" => "season",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 10,
            },
            {
              "active" => true,
              "name" => "show",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 11,
            },
            {
              "active" => true,
              "name" => "summary",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 12,
            },
            {
              "active" => true,
              "name" => "type",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 13,
            },
            {
              "active" => true,
              "name" => "url",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 14,
            },
          ],
          "name" => "scheduled_episode",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "country",
                        "orig" => "country",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "date",
                        "orig" => "date",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/schedule/web",
                  "parts" => [
                    "schedule",
                    "web",
                  ],
                  "select" => {
                    "exist" => [
                      "country",
                      "date",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
                {
                  "active" => true,
                  "args" => {},
                  "method" => "GET",
                  "orig" => "/schedule/full",
                  "parts" => [
                    "schedule",
                    "full",
                  ],
                  "select" => {},
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 1,
                },
              ],
              "key$" => "list",
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "search" => {
          "fields" => [],
          "name" => "search",
          "op" => {
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "imdb",
                        "orig" => "imdb",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "thetvdb",
                        "orig" => "thetvdb",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "tvrage",
                        "orig" => "tvrage",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/lookup/shows",
                  "parts" => [
                    "lookup",
                    "shows",
                  ],
                  "select" => {
                    "exist" => [
                      "imdb",
                      "thetvdb",
                      "tvrage",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "load",
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
        "season" => {
          "fields" => [
            {
              "active" => true,
              "name" => "end_date",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "episode_order",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 1,
            },
            {
              "active" => true,
              "name" => "id",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 2,
            },
            {
              "active" => true,
              "name" => "image",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 3,
            },
            {
              "active" => true,
              "name" => "link",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 4,
            },
            {
              "active" => true,
              "name" => "name",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 5,
            },
            {
              "active" => true,
              "name" => "network",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 6,
            },
            {
              "active" => true,
              "name" => "number",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 7,
            },
            {
              "active" => true,
              "name" => "premiere_date",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 8,
            },
            {
              "active" => true,
              "name" => "summary",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 9,
            },
            {
              "active" => true,
              "name" => "url",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 10,
            },
            {
              "active" => true,
              "name" => "web_channel",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 11,
            },
          ],
          "name" => "season",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "show_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/shows/{id}/seasons",
                  "parts" => [
                    "shows",
                    "{show_id}",
                    "seasons",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "show_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "show_id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "list",
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "show",
              ],
            ],
          },
        },
        "show" => {
          "fields" => [
            {
              "active" => true,
              "name" => "average_runtime",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 0,
            },
            {
              "active" => true,
              "name" => "dvd_country",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 1,
            },
            {
              "active" => true,
              "name" => "ended",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 2,
            },
            {
              "active" => true,
              "name" => "external",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 3,
            },
            {
              "active" => true,
              "name" => "genre",
              "req" => false,
              "type" => "`$ARRAY`",
              "index$" => 4,
            },
            {
              "active" => true,
              "name" => "id",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 5,
            },
            {
              "active" => true,
              "name" => "image",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 6,
            },
            {
              "active" => true,
              "name" => "language",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 7,
            },
            {
              "active" => true,
              "name" => "link",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 8,
            },
            {
              "active" => true,
              "name" => "name",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 9,
            },
            {
              "active" => true,
              "name" => "network",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 10,
            },
            {
              "active" => true,
              "name" => "official_site",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 11,
            },
            {
              "active" => true,
              "name" => "premiered",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 12,
            },
            {
              "active" => true,
              "name" => "rating",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 13,
            },
            {
              "active" => true,
              "name" => "runtime",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 14,
            },
            {
              "active" => true,
              "name" => "schedule",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 15,
            },
            {
              "active" => true,
              "name" => "score",
              "req" => false,
              "type" => "`$NUMBER`",
              "index$" => 16,
            },
            {
              "active" => true,
              "name" => "show",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 17,
            },
            {
              "active" => true,
              "name" => "status",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 18,
            },
            {
              "active" => true,
              "name" => "summary",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 19,
            },
            {
              "active" => true,
              "name" => "type",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 20,
            },
            {
              "active" => true,
              "name" => "updated",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 21,
            },
            {
              "active" => true,
              "name" => "url",
              "req" => false,
              "type" => "`$STRING`",
              "index$" => 22,
            },
            {
              "active" => true,
              "name" => "web_channel",
              "req" => false,
              "type" => "`$OBJECT`",
              "index$" => 23,
            },
            {
              "active" => true,
              "name" => "weight",
              "req" => false,
              "type" => "`$INTEGER`",
              "index$" => 24,
            },
          ],
          "name" => "show",
          "op" => {
            "list" => {
              "input" => "data",
              "name" => "list",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "alternatelist_id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "embed",
                        "orig" => "embed",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/alternatelists/{id}/alternateepisodes",
                  "parts" => [
                    "alternatelists",
                    "{alternatelist_id}",
                    "alternateepisodes",
                  ],
                  "rename" => {
                    "param" => {
                      "id" => "alternatelist_id",
                    },
                  },
                  "select" => {
                    "exist" => [
                      "alternatelist_id",
                      "embed",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
                {
                  "active" => true,
                  "args" => {
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "embed",
                        "orig" => "embed",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "q",
                        "orig" => "q",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/singlesearch/shows",
                  "parts" => [
                    "singlesearch",
                    "shows",
                  ],
                  "select" => {
                    "exist" => [
                      "embed",
                      "q",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 1,
                },
                {
                  "active" => true,
                  "args" => {
                    "query" => [
                      {
                        "active" => true,
                        "example" => 0,
                        "kind" => "query",
                        "name" => "page",
                        "orig" => "page",
                        "reqd" => false,
                        "type" => "`$INTEGER`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/shows",
                  "parts" => [
                    "shows",
                  ],
                  "select" => {
                    "exist" => [
                      "page",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 2,
                },
                {
                  "active" => true,
                  "args" => {
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "q",
                        "orig" => "q",
                        "reqd" => true,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/search/shows",
                  "parts" => [
                    "search",
                    "shows",
                  ],
                  "select" => {
                    "exist" => [
                      "q",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 3,
                },
              ],
              "key$" => "list",
            },
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "params" => [
                      {
                        "active" => true,
                        "kind" => "param",
                        "name" => "id",
                        "orig" => "id",
                        "reqd" => true,
                        "type" => "`$INTEGER`",
                        "index$" => 0,
                      },
                    ],
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "embed",
                        "orig" => "embed",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/shows/{id}",
                  "parts" => [
                    "shows",
                    "{id}",
                  ],
                  "select" => {
                    "exist" => [
                      "embed",
                      "id",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
              ],
              "key$" => "load",
            },
          },
          "relations" => {
            "ancestors" => [
              [
                "alternatelist",
              ],
            ],
          },
        },
        "update" => {
          "fields" => [],
          "name" => "update",
          "op" => {
            "load" => {
              "input" => "data",
              "name" => "load",
              "points" => [
                {
                  "active" => true,
                  "args" => {
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "since",
                        "orig" => "since",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/updates/people",
                  "parts" => [
                    "updates",
                    "people",
                  ],
                  "select" => {
                    "$action" => "person",
                    "exist" => [
                      "since",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 0,
                },
                {
                  "active" => true,
                  "args" => {
                    "query" => [
                      {
                        "active" => true,
                        "kind" => "query",
                        "name" => "since",
                        "orig" => "since",
                        "reqd" => false,
                        "type" => "`$STRING`",
                      },
                    ],
                  },
                  "method" => "GET",
                  "orig" => "/updates/shows",
                  "parts" => [
                    "updates",
                    "shows",
                  ],
                  "select" => {
                    "$action" => "show",
                    "exist" => [
                      "since",
                    ],
                  },
                  "transform" => {
                    "req" => "`reqdata`",
                    "res" => "`body`",
                  },
                  "index$" => 1,
                },
              ],
              "key$" => "load",
            },
          },
          "relations" => {
            "ancestors" => [],
          },
        },
      },
    }
  end


  def self.make_feature(name)
    require_relative 'features'
    TvmazeFeatures.make_feature(name)
  end
end
