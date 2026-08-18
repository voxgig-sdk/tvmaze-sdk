
import { BaseFeature } from './feature/base/BaseFeature'
import { TestFeature } from './feature/test/TestFeature'



const FEATURE_CLASS: Record<string, typeof BaseFeature> = {
   test: TestFeature,

}


class Config {

  makeFeature(this: any, fn: string) {
    const fc = FEATURE_CLASS[fn]
    const fi = new fc()
    // TODO: errors etc
    return fi
  }


  main = {
    name: 'Tvmaze',
  }


  feature = {
     test:     {
      "options": {
        "active": false
      }
    },

  }


  options = {
    base: "https://api.tvmaze.com",

    headers: {
      "content-type": "application/json"
    },

    entity: {
      
      aka: {
      },

      alternate_list: {
      },

      cast: {
      },

      cast_credit: {
      },

      cast_member: {
      },

      crew: {
      },

      crew_credit: {
      },

      crew_member: {
      },

      episode: {
      },

      guest_cast_credit: {
      },

      image: {
      },

      person: {
      },

      schedule: {
      },

      scheduled_episode: {
      },

      search: {
      },

      season: {
      },

      show: {
      },

      update: {
      },

    }
  }


  entity = {
    "aka": {
      "fields": [
        {
          "name": "country",
          "type": "`$OBJECT`"
        },
        {
          "name": "name",
          "type": "`$STRING`"
        }
      ],
      "name": "aka",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "show_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/shows/{id}/akas",
              "parts": [
                "shows",
                "{show_id}",
                "akas"
              ],
              "rename": {
                "param": {
                  "id": "show_id"
                }
              },
              "select": {
                "exist": [
                  "show_id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "show"
          ]
        ]
      }
    },
    "alternate_list": {
      "fields": [
        {
          "name": "id",
          "type": "`$INTEGER`"
        },
        {
          "name": "links",
          "type": "`$OBJECT`"
        },
        {
          "name": "name",
          "type": "`$STRING`"
        },
        {
          "name": "self",
          "type": "`$OBJECT`"
        },
        {
          "name": "url",
          "type": "`$STRING`"
        }
      ],
      "name": "alternate_list",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "show_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/shows/{id}/alternatelists",
              "parts": [
                "shows",
                "{show_id}",
                "alternatelists"
              ],
              "rename": {
                "param": {
                  "id": "show_id"
                }
              },
              "select": {
                "exist": [
                  "show_id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ],
                "query": [
                  {
                    "kind": "query",
                    "name": "embed",
                    "orig": "embed",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/alternatelists/{id}",
              "parts": [
                "alternatelists",
                "{id}"
              ],
              "select": {
                "exist": [
                  "embed",
                  "id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body._links`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "show"
          ]
        ]
      }
    },
    "cast": {
      "fields": [
        {
          "name": "character",
          "type": "`$OBJECT`"
        },
        {
          "name": "person",
          "type": "`$OBJECT`"
        },
        {
          "name": "self",
          "type": "`$BOOLEAN`"
        },
        {
          "name": "voice",
          "type": "`$BOOLEAN`"
        }
      ],
      "name": "cast",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "show_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/shows/{id}/cast",
              "parts": [
                "shows",
                "{show_id}",
                "cast"
              ],
              "rename": {
                "param": {
                  "id": "show_id"
                }
              },
              "select": {
                "exist": [
                  "show_id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "show"
          ]
        ]
      }
    },
    "cast_credit": {
      "fields": [
        {
          "name": "links",
          "type": "`$OBJECT`"
        }
      ],
      "name": "cast_credit",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "person_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ],
                "query": [
                  {
                    "kind": "query",
                    "name": "embed",
                    "orig": "embed",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/people/{id}/castcredits",
              "parts": [
                "people",
                "{person_id}",
                "castcredits"
              ],
              "rename": {
                "param": {
                  "id": "person_id"
                }
              },
              "select": {
                "exist": [
                  "embed",
                  "person_id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "person"
          ]
        ]
      }
    },
    "cast_member": {
      "fields": [
        {
          "name": "character",
          "type": "`$OBJECT`"
        },
        {
          "name": "person",
          "type": "`$OBJECT`"
        },
        {
          "name": "self",
          "type": "`$BOOLEAN`"
        },
        {
          "name": "voice",
          "type": "`$BOOLEAN`"
        }
      ],
      "name": "cast_member",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "episode_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/episodes/{id}/guestcast",
              "parts": [
                "episodes",
                "{episode_id}",
                "guestcast"
              ],
              "rename": {
                "param": {
                  "id": "episode_id"
                }
              },
              "select": {
                "exist": [
                  "episode_id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "episode"
          ]
        ]
      }
    },
    "crew": {
      "fields": [
        {
          "name": "person",
          "type": "`$OBJECT`"
        },
        {
          "name": "type",
          "type": "`$STRING`"
        }
      ],
      "name": "crew",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "show_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/shows/{id}/crew",
              "parts": [
                "shows",
                "{show_id}",
                "crew"
              ],
              "rename": {
                "param": {
                  "id": "show_id"
                }
              },
              "select": {
                "exist": [
                  "show_id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "show"
          ]
        ]
      }
    },
    "crew_credit": {
      "fields": [
        {
          "name": "links",
          "type": "`$OBJECT`"
        },
        {
          "name": "type",
          "type": "`$STRING`"
        }
      ],
      "name": "crew_credit",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "person_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ],
                "query": [
                  {
                    "kind": "query",
                    "name": "embed",
                    "orig": "embed",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/people/{id}/crewcredits",
              "parts": [
                "people",
                "{person_id}",
                "crewcredits"
              ],
              "rename": {
                "param": {
                  "id": "person_id"
                }
              },
              "select": {
                "exist": [
                  "embed",
                  "person_id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "person"
          ]
        ]
      }
    },
    "crew_member": {
      "fields": [
        {
          "name": "person",
          "type": "`$OBJECT`"
        },
        {
          "name": "type",
          "type": "`$STRING`"
        }
      ],
      "name": "crew_member",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "episode_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/episodes/{id}/guestcrew",
              "parts": [
                "episodes",
                "{episode_id}",
                "guestcrew"
              ],
              "rename": {
                "param": {
                  "id": "episode_id"
                }
              },
              "select": {
                "exist": [
                  "episode_id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "episode"
          ]
        ]
      }
    },
    "episode": {
      "fields": [
        {
          "name": "airdate",
          "type": "`$STRING`"
        },
        {
          "name": "airstamp",
          "type": "`$STRING`"
        },
        {
          "name": "airtime",
          "type": "`$STRING`"
        },
        {
          "name": "id",
          "type": "`$INTEGER`"
        },
        {
          "name": "image",
          "type": "`$OBJECT`"
        },
        {
          "name": "links",
          "type": "`$OBJECT`"
        },
        {
          "name": "name",
          "type": "`$STRING`"
        },
        {
          "name": "number",
          "type": "`$INTEGER`"
        },
        {
          "name": "rating",
          "type": "`$OBJECT`"
        },
        {
          "name": "runtime",
          "type": "`$INTEGER`"
        },
        {
          "name": "season",
          "type": "`$INTEGER`"
        },
        {
          "name": "summary",
          "type": "`$STRING`"
        },
        {
          "name": "type",
          "type": "`$STRING`"
        },
        {
          "name": "url",
          "type": "`$STRING`"
        }
      ],
      "name": "episode",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "show_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ],
                "query": [
                  {
                    "kind": "query",
                    "name": "date",
                    "orig": "date",
                    "reqd": true,
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/shows/{id}/episodesbydate",
              "parts": [
                "shows",
                "{show_id}",
                "episodesbydate"
              ],
              "rename": {
                "param": {
                  "id": "show_id"
                }
              },
              "select": {
                "exist": [
                  "date",
                  "show_id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "season_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ],
                "query": [
                  {
                    "kind": "query",
                    "name": "embed",
                    "orig": "embed",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/seasons/{id}/episodes",
              "parts": [
                "seasons",
                "{season_id}",
                "episodes"
              ],
              "rename": {
                "param": {
                  "id": "season_id"
                }
              },
              "select": {
                "exist": [
                  "embed",
                  "season_id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "show_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ],
                "query": [
                  {
                    "kind": "query",
                    "name": "special",
                    "orig": "special",
                    "type": "`$INTEGER`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/shows/{id}/episodes",
              "parts": [
                "shows",
                "{show_id}",
                "episodes"
              ],
              "rename": {
                "param": {
                  "id": "show_id"
                }
              },
              "select": {
                "exist": [
                  "show_id",
                  "special"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "show_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ],
                "query": [
                  {
                    "kind": "query",
                    "name": "number",
                    "orig": "number",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  },
                  {
                    "kind": "query",
                    "name": "season",
                    "orig": "season",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/shows/{id}/episodebynumber",
              "parts": [
                "shows",
                "{show_id}",
                "episodebynumber"
              ],
              "rename": {
                "param": {
                  "id": "show_id"
                }
              },
              "select": {
                "exist": [
                  "number",
                  "season",
                  "show_id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ],
                "query": [
                  {
                    "kind": "query",
                    "name": "embed",
                    "orig": "embed",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/episodes/{id}",
              "parts": [
                "episodes",
                "{id}"
              ],
              "select": {
                "exist": [
                  "embed",
                  "id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "season"
          ],
          [
            "show"
          ]
        ]
      }
    },
    "guest_cast_credit": {
      "fields": [
        {
          "name": "links",
          "type": "`$OBJECT`"
        }
      ],
      "name": "guest_cast_credit",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "person_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ],
                "query": [
                  {
                    "kind": "query",
                    "name": "embed",
                    "orig": "embed",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/people/{id}/guestcastcredits",
              "parts": [
                "people",
                "{person_id}",
                "guestcastcredits"
              ],
              "rename": {
                "param": {
                  "id": "person_id"
                }
              },
              "select": {
                "exist": [
                  "embed",
                  "person_id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "person"
          ]
        ]
      }
    },
    "image": {
      "fields": [
        {
          "name": "id",
          "type": "`$INTEGER`"
        },
        {
          "name": "main",
          "type": "`$BOOLEAN`"
        },
        {
          "name": "resolutions",
          "type": "`$OBJECT`"
        },
        {
          "name": "type",
          "type": "`$STRING`"
        }
      ],
      "name": "image",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "show_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/shows/{id}/images",
              "parts": [
                "shows",
                "{show_id}",
                "images"
              ],
              "rename": {
                "param": {
                  "id": "show_id"
                }
              },
              "select": {
                "exist": [
                  "show_id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "show"
          ]
        ]
      }
    },
    "person": {
      "fields": [
        {
          "name": "birthday",
          "type": "`$STRING`"
        },
        {
          "name": "country",
          "type": "`$OBJECT`"
        },
        {
          "name": "deathday",
          "type": "`$STRING`"
        },
        {
          "name": "gender",
          "type": "`$STRING`"
        },
        {
          "name": "id",
          "type": "`$INTEGER`"
        },
        {
          "name": "image",
          "type": "`$OBJECT`"
        },
        {
          "name": "links",
          "type": "`$OBJECT`"
        },
        {
          "name": "name",
          "type": "`$STRING`"
        },
        {
          "name": "person",
          "type": "`$OBJECT`"
        },
        {
          "name": "score",
          "type": "`$NUMBER`"
        },
        {
          "name": "updated",
          "type": "`$INTEGER`"
        },
        {
          "name": "url",
          "type": "`$STRING`"
        }
      ],
      "name": "person",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "query": [
                  {
                    "example": 0,
                    "kind": "query",
                    "name": "page",
                    "orig": "page",
                    "type": "`$INTEGER`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/people",
              "parts": [
                "people"
              ],
              "select": {
                "exist": [
                  "page"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {
                "query": [
                  {
                    "kind": "query",
                    "name": "q",
                    "orig": "q",
                    "reqd": true,
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/search/people",
              "parts": [
                "search",
                "people"
              ],
              "select": {
                "exist": [
                  "q"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ],
                "query": [
                  {
                    "kind": "query",
                    "name": "embed",
                    "orig": "embed",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/people/{id}",
              "parts": [
                "people",
                "{id}"
              ],
              "select": {
                "exist": [
                  "embed",
                  "id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "schedule": {
      "fields": [
        {
          "name": "airdate",
          "type": "`$STRING`"
        },
        {
          "name": "airstamp",
          "type": "`$STRING`"
        },
        {
          "name": "airtime",
          "type": "`$STRING`"
        },
        {
          "name": "id",
          "type": "`$INTEGER`"
        },
        {
          "name": "image",
          "type": "`$OBJECT`"
        },
        {
          "name": "links",
          "type": "`$OBJECT`"
        },
        {
          "name": "name",
          "type": "`$STRING`"
        },
        {
          "name": "number",
          "type": "`$INTEGER`"
        },
        {
          "name": "rating",
          "type": "`$OBJECT`"
        },
        {
          "name": "runtime",
          "type": "`$INTEGER`"
        },
        {
          "name": "season",
          "type": "`$INTEGER`"
        },
        {
          "name": "show",
          "type": "`$OBJECT`"
        },
        {
          "name": "summary",
          "type": "`$STRING`"
        },
        {
          "name": "type",
          "type": "`$STRING`"
        },
        {
          "name": "url",
          "type": "`$STRING`"
        }
      ],
      "name": "schedule",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "query": [
                  {
                    "example": "US",
                    "kind": "query",
                    "name": "country",
                    "orig": "country",
                    "type": "`$STRING`"
                  },
                  {
                    "kind": "query",
                    "name": "date",
                    "orig": "date",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/schedule",
              "parts": [
                "schedule"
              ],
              "select": {
                "exist": [
                  "country",
                  "date"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "scheduled_episode": {
      "fields": [
        {
          "name": "airdate",
          "type": "`$STRING`"
        },
        {
          "name": "airstamp",
          "type": "`$STRING`"
        },
        {
          "name": "airtime",
          "type": "`$STRING`"
        },
        {
          "name": "id",
          "type": "`$INTEGER`"
        },
        {
          "name": "image",
          "type": "`$OBJECT`"
        },
        {
          "name": "links",
          "type": "`$OBJECT`"
        },
        {
          "name": "name",
          "type": "`$STRING`"
        },
        {
          "name": "number",
          "type": "`$INTEGER`"
        },
        {
          "name": "rating",
          "type": "`$OBJECT`"
        },
        {
          "name": "runtime",
          "type": "`$INTEGER`"
        },
        {
          "name": "season",
          "type": "`$INTEGER`"
        },
        {
          "name": "show",
          "type": "`$OBJECT`"
        },
        {
          "name": "summary",
          "type": "`$STRING`"
        },
        {
          "name": "type",
          "type": "`$STRING`"
        },
        {
          "name": "url",
          "type": "`$STRING`"
        }
      ],
      "name": "scheduled_episode",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "query": [
                  {
                    "kind": "query",
                    "name": "country",
                    "orig": "country",
                    "type": "`$STRING`"
                  },
                  {
                    "kind": "query",
                    "name": "date",
                    "orig": "date",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/schedule/web",
              "parts": [
                "schedule",
                "web"
              ],
              "select": {
                "exist": [
                  "country",
                  "date"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {},
              "kind": "http",
              "method": "GET",
              "orig": "/schedule/full",
              "parts": [
                "schedule",
                "full"
              ],
              "select": {},
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "search": {
      "fields": [],
      "name": "search",
      "op": {
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "args": {
                "query": [
                  {
                    "kind": "query",
                    "name": "imdb",
                    "orig": "imdb",
                    "type": "`$STRING`"
                  },
                  {
                    "kind": "query",
                    "name": "thetvdb",
                    "orig": "thetvdb",
                    "type": "`$STRING`"
                  },
                  {
                    "kind": "query",
                    "name": "tvrage",
                    "orig": "tvrage",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/lookup/shows",
              "parts": [
                "lookup",
                "shows"
              ],
              "select": {
                "exist": [
                  "imdb",
                  "thetvdb",
                  "tvrage"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    },
    "season": {
      "fields": [
        {
          "name": "endDate",
          "type": "`$STRING`"
        },
        {
          "name": "episodeOrder",
          "type": "`$INTEGER`"
        },
        {
          "name": "id",
          "type": "`$INTEGER`"
        },
        {
          "name": "image",
          "type": "`$OBJECT`"
        },
        {
          "name": "links",
          "type": "`$OBJECT`"
        },
        {
          "name": "name",
          "type": "`$STRING`"
        },
        {
          "name": "network",
          "type": "`$OBJECT`"
        },
        {
          "name": "number",
          "type": "`$INTEGER`"
        },
        {
          "name": "premiereDate",
          "type": "`$STRING`"
        },
        {
          "name": "summary",
          "type": "`$STRING`"
        },
        {
          "name": "url",
          "type": "`$STRING`"
        },
        {
          "name": "webChannel",
          "type": "`$OBJECT`"
        }
      ],
      "name": "season",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "show_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/shows/{id}/seasons",
              "parts": [
                "shows",
                "{show_id}",
                "seasons"
              ],
              "rename": {
                "param": {
                  "id": "show_id"
                }
              },
              "select": {
                "exist": [
                  "show_id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "show"
          ]
        ]
      }
    },
    "show": {
      "fields": [
        {
          "name": "averageRuntime",
          "type": "`$INTEGER`"
        },
        {
          "name": "dvdCountry",
          "type": "`$OBJECT`"
        },
        {
          "name": "ended",
          "type": "`$STRING`"
        },
        {
          "name": "externals",
          "type": "`$OBJECT`"
        },
        {
          "name": "genres",
          "type": "`$ARRAY`"
        },
        {
          "name": "id",
          "type": "`$INTEGER`"
        },
        {
          "name": "image",
          "type": "`$OBJECT`"
        },
        {
          "name": "language",
          "type": "`$STRING`"
        },
        {
          "name": "links",
          "type": "`$OBJECT`"
        },
        {
          "name": "name",
          "type": "`$STRING`"
        },
        {
          "name": "network",
          "type": "`$OBJECT`"
        },
        {
          "name": "officialSite",
          "type": "`$STRING`"
        },
        {
          "name": "premiered",
          "type": "`$STRING`"
        },
        {
          "name": "rating",
          "type": "`$OBJECT`"
        },
        {
          "name": "runtime",
          "type": "`$INTEGER`"
        },
        {
          "name": "schedule",
          "type": "`$OBJECT`"
        },
        {
          "name": "score",
          "type": "`$NUMBER`"
        },
        {
          "name": "show",
          "type": "`$OBJECT`"
        },
        {
          "name": "status",
          "type": "`$STRING`"
        },
        {
          "name": "summary",
          "type": "`$STRING`"
        },
        {
          "name": "type",
          "type": "`$STRING`"
        },
        {
          "name": "updated",
          "type": "`$INTEGER`"
        },
        {
          "name": "url",
          "type": "`$STRING`"
        },
        {
          "name": "webChannel",
          "type": "`$OBJECT`"
        },
        {
          "name": "weight",
          "type": "`$INTEGER`"
        }
      ],
      "name": "show",
      "op": {
        "list": {
          "input": "data",
          "name": "list",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "alternatelist_id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ],
                "query": [
                  {
                    "kind": "query",
                    "name": "embed",
                    "orig": "embed",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/alternatelists/{id}/alternateepisodes",
              "parts": [
                "alternatelists",
                "{alternatelist_id}",
                "alternateepisodes"
              ],
              "rename": {
                "param": {
                  "id": "alternatelist_id"
                }
              },
              "select": {
                "exist": [
                  "alternatelist_id",
                  "embed"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {
                "query": [
                  {
                    "kind": "query",
                    "name": "embed",
                    "orig": "embed",
                    "type": "`$STRING`"
                  },
                  {
                    "kind": "query",
                    "name": "q",
                    "orig": "q",
                    "reqd": true,
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/singlesearch/shows",
              "parts": [
                "singlesearch",
                "shows"
              ],
              "select": {
                "exist": [
                  "embed",
                  "q"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {
                "query": [
                  {
                    "example": 0,
                    "kind": "query",
                    "name": "page",
                    "orig": "page",
                    "type": "`$INTEGER`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/shows",
              "parts": [
                "shows"
              ],
              "select": {
                "exist": [
                  "page"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {
                "query": [
                  {
                    "kind": "query",
                    "name": "q",
                    "orig": "q",
                    "reqd": true,
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/search/shows",
              "parts": [
                "search",
                "shows"
              ],
              "select": {
                "exist": [
                  "q"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        },
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "args": {
                "params": [
                  {
                    "kind": "param",
                    "name": "id",
                    "orig": "id",
                    "reqd": true,
                    "type": "`$INTEGER`"
                  }
                ],
                "query": [
                  {
                    "kind": "query",
                    "name": "embed",
                    "orig": "embed",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/shows/{id}",
              "parts": [
                "shows",
                "{id}"
              ],
              "select": {
                "exist": [
                  "embed",
                  "id"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": [
          [
            "alternatelist"
          ]
        ]
      }
    },
    "update": {
      "fields": [],
      "name": "update",
      "op": {
        "load": {
          "input": "data",
          "name": "load",
          "points": [
            {
              "args": {
                "query": [
                  {
                    "kind": "query",
                    "name": "since",
                    "orig": "since",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/updates/people",
              "parts": [
                "updates",
                "people"
              ],
              "select": {
                "$action": "person",
                "exist": [
                  "since"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            },
            {
              "args": {
                "query": [
                  {
                    "kind": "query",
                    "name": "since",
                    "orig": "since",
                    "type": "`$STRING`"
                  }
                ]
              },
              "kind": "http",
              "method": "GET",
              "orig": "/updates/shows",
              "parts": [
                "updates",
                "shows"
              ],
              "select": {
                "$action": "show",
                "exist": [
                  "since"
                ]
              },
              "transform": {
                "req": "`reqdata`",
                "res": "`body`"
              }
            }
          ]
        }
      },
      "relations": {
        "ancestors": []
      }
    }
  }
}


const config = new Config()

export {
  config
}

