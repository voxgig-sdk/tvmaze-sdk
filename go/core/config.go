package core

import (
	"sync"
)

// MakeConfig builds a fresh, fully materialised config map. Every call
// rebuilds the whole structure, so prefer SharedConfig unless you need a
// private copy you intend to mutate.
func MakeConfig() map[string]any {
	return map[string]any{
		"main": map[string]any{
			"name": "Tvmaze",
			"slug": "tvmaze",
			"version": "0.0.1",
			"target": "go",
		},
		"feature": map[string]any{
			"test": map[string]any{
				"options": map[string]any{
					"active": false,
				},
				"transport": "base",
			},
		},
		"options": map[string]any{
			"base": "https://api.tvmaze.com",
			"headers": map[string]any{
				"content-type": "application/json",
			},
			"entity": map[string]any{
				"aka": map[string]any{},
				"alternate_list": map[string]any{},
				"cast": map[string]any{},
				"cast_credit": map[string]any{},
				"cast_member": map[string]any{},
				"crew": map[string]any{},
				"crew_credit": map[string]any{},
				"crew_member": map[string]any{},
				"episode": map[string]any{},
				"guest_cast_credit": map[string]any{},
				"image": map[string]any{},
				"person": map[string]any{},
				"schedule": map[string]any{},
				"scheduled_episode": map[string]any{},
				"search": map[string]any{},
				"season": map[string]any{},
				"show": map[string]any{},
				"update": map[string]any{},
			},
		},
		"entity": map[string]any{
			"aka": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "country",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "name",
						"short": "Alternate name",
						"type": "`$STRING`",
					},
				},
				"name": "aka",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "show_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/shows/{id}/akas",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "show_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "shows",
									},
									map[string]any{
										"var": "show_id",
									},
									map[string]any{
										"lit": "akas",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"show_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"shows",
									"{show_id}",
									"akas",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"show",
						},
					},
				},
			},
			"alternate_list": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "id",
						"short": "Unique alternate list identifier",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "links",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "name",
						"short": "Name of alternate list (e.g., DVD Order)",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "self",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "url",
						"short": "TVmaze URL for the alternate list",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "alternate_list",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "show_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/shows/{id}/alternatelists",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "show_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "shows",
									},
									map[string]any{
										"var": "show_id",
									},
									map[string]any{
										"lit": "alternatelists",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"show_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"shows",
									"{show_id}",
									"alternatelists",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "embed",
											"orig": "embed",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/alternatelists/{id}",
								"segments": []any{
									map[string]any{
										"lit": "alternatelists",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"embed",
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body._links`",
								},
								"parts": []any{
									"alternatelists",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"show",
						},
					},
				},
			},
			"cast": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "character",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "person",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "self",
						"short": "Whether person plays themselves",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "voice",
						"short": "Whether this is a voice role",
						"type": "`$BOOLEAN`",
					},
				},
				"name": "cast",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "show_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/shows/{id}/cast",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "show_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "shows",
									},
									map[string]any{
										"var": "show_id",
									},
									map[string]any{
										"lit": "cast",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"show_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"shows",
									"{show_id}",
									"cast",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"show",
						},
					},
				},
			},
			"cast_credit": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "links",
						"type": "`$OBJECT`",
					},
				},
				"name": "cast_credit",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "person_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "embed",
											"orig": "embed",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/people/{id}/castcredits",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "person_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "people",
									},
									map[string]any{
										"var": "person_id",
									},
									map[string]any{
										"lit": "castcredits",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"embed",
										"person_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"people",
									"{person_id}",
									"castcredits",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"person",
						},
					},
				},
			},
			"cast_member": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "character",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "person",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "self",
						"short": "Whether person plays themselves",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "voice",
						"short": "Whether this is a voice role",
						"type": "`$BOOLEAN`",
					},
				},
				"name": "cast_member",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "episode_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/episodes/{id}/guestcast",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "episode_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "episodes",
									},
									map[string]any{
										"var": "episode_id",
									},
									map[string]any{
										"lit": "guestcast",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"episode_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"episodes",
									"{episode_id}",
									"guestcast",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"episode",
						},
					},
				},
			},
			"crew": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "person",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "type",
						"short": "Crew type (e.g., Executive Producer)",
						"type": "`$STRING`",
					},
				},
				"name": "crew",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "show_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/shows/{id}/crew",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "show_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "shows",
									},
									map[string]any{
										"var": "show_id",
									},
									map[string]any{
										"lit": "crew",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"show_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"shows",
									"{show_id}",
									"crew",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"show",
						},
					},
				},
			},
			"crew_credit": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "links",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "type",
						"short": "Crew type",
						"type": "`$STRING`",
					},
				},
				"name": "crew_credit",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "person_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "embed",
											"orig": "embed",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/people/{id}/crewcredits",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "person_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "people",
									},
									map[string]any{
										"var": "person_id",
									},
									map[string]any{
										"lit": "crewcredits",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"embed",
										"person_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"people",
									"{person_id}",
									"crewcredits",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"person",
						},
					},
				},
			},
			"crew_member": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "person",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "type",
						"short": "Crew type (e.g., Executive Producer)",
						"type": "`$STRING`",
					},
				},
				"name": "crew_member",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "episode_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/episodes/{id}/guestcrew",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "episode_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "episodes",
									},
									map[string]any{
										"var": "episode_id",
									},
									map[string]any{
										"lit": "guestcrew",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"episode_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"episodes",
									"{episode_id}",
									"guestcrew",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"episode",
						},
					},
				},
			},
			"episode": map[string]any{
				"fields": []any{
					map[string]any{
						"format": "date",
						"name": "airdate",
						"short": "Air date",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "date-time",
						"name": "airstamp",
						"short": "Air timestamp",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "airtime",
						"short": "Air time",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "id",
						"short": "Unique episode identifier",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "image",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "links",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "name",
						"short": "Episode name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "number",
						"short": "Episode number in season",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "rating",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "runtime",
						"short": "Runtime in minutes",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "season",
						"short": "Season number",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "summary",
						"short": "HTML summary",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"short": "Episode type (e.g., regular, significant_special)",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "url",
						"short": "TVmaze URL for the episode",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "episode",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "show_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "date",
											"orig": "date",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/shows/{id}/episodesbydate",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "show_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "shows",
									},
									map[string]any{
										"var": "show_id",
									},
									map[string]any{
										"lit": "episodesbydate",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"date",
										"show_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"shows",
									"{show_id}",
									"episodesbydate",
								},
							},
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "season_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "embed",
											"orig": "embed",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/seasons/{id}/episodes",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "season_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "seasons",
									},
									map[string]any{
										"var": "season_id",
									},
									map[string]any{
										"lit": "episodes",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"embed",
										"season_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"seasons",
									"{season_id}",
									"episodes",
								},
							},
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "show_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "special",
											"orig": "special",
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/shows/{id}/episodes",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "show_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "shows",
									},
									map[string]any{
										"var": "show_id",
									},
									map[string]any{
										"lit": "episodes",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"show_id",
										"special",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"shows",
									"{show_id}",
									"episodes",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "show_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "number",
											"orig": "number",
											"reqd": true,
											"type": "`$INTEGER`",
										},
										map[string]any{
											"kind": "query",
											"name": "season",
											"orig": "season",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/shows/{id}/episodebynumber",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "show_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "shows",
									},
									map[string]any{
										"var": "show_id",
									},
									map[string]any{
										"lit": "episodebynumber",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"number",
										"season",
										"show_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"shows",
									"{show_id}",
									"episodebynumber",
								},
							},
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "embed",
											"orig": "embed",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/episodes/{id}",
								"segments": []any{
									map[string]any{
										"lit": "episodes",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"embed",
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"episodes",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"season",
						},
						[]any{
							"show",
						},
					},
				},
			},
			"guest_cast_credit": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "links",
						"type": "`$OBJECT`",
					},
				},
				"name": "guest_cast_credit",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "person_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "embed",
											"orig": "embed",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/people/{id}/guestcastcredits",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "person_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "people",
									},
									map[string]any{
										"var": "person_id",
									},
									map[string]any{
										"lit": "guestcastcredits",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"embed",
										"person_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"people",
									"{person_id}",
									"guestcastcredits",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"person",
						},
					},
				},
			},
			"image": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "id",
						"short": "Unique image identifier",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "main",
						"short": "Whether this is the main image",
						"type": "`$BOOLEAN`",
					},
					map[string]any{
						"name": "resolutions",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "type",
						"short": "Image type",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "image",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "show_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/shows/{id}/images",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "show_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "shows",
									},
									map[string]any{
										"var": "show_id",
									},
									map[string]any{
										"lit": "images",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"show_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"shows",
									"{show_id}",
									"images",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"show",
						},
					},
				},
			},
			"person": map[string]any{
				"fields": []any{
					map[string]any{
						"format": "date",
						"name": "birthday",
						"short": "Birth date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "country",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"format": "date",
						"name": "deathday",
						"short": "Death date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "gender",
						"short": "Gender",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "id",
						"short": "Unique person identifier",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "image",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "links",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "name",
						"short": "Person name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "person",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "score",
						"short": "Search relevancy score",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "updated",
						"short": "Unix timestamp of last update",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "url",
						"short": "TVmaze URL for the person",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "person",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "page",
											"orig": "page",
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/people",
								"segments": []any{
									map[string]any{
										"lit": "people",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"page",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"people",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "q",
											"orig": "q",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/search/people",
								"segments": []any{
									map[string]any{
										"lit": "search",
									},
									map[string]any{
										"lit": "people",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"q",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"search",
									"people",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "embed",
											"orig": "embed",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/people/{id}",
								"segments": []any{
									map[string]any{
										"lit": "people",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"embed",
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"people",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"schedule": map[string]any{
				"fields": []any{
					map[string]any{
						"format": "date",
						"name": "airdate",
						"short": "Air date",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "date-time",
						"name": "airstamp",
						"short": "Air timestamp",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "airtime",
						"short": "Air time",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "id",
						"short": "Unique episode identifier",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "image",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "links",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "name",
						"short": "Episode name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "number",
						"short": "Episode number in season",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "rating",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "runtime",
						"short": "Runtime in minutes",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "season",
						"short": "Season number",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "show",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "summary",
						"short": "HTML summary",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"short": "Episode type (e.g., regular, significant_special)",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "url",
						"short": "TVmaze URL for the episode",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "schedule",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"example": "US",
											"kind": "query",
											"name": "country",
											"orig": "country",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "date",
											"orig": "date",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/schedule",
								"segments": []any{
									map[string]any{
										"lit": "schedule",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"country",
										"date",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"schedule",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"scheduled_episode": map[string]any{
				"fields": []any{
					map[string]any{
						"format": "date",
						"name": "airdate",
						"short": "Air date",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "date-time",
						"name": "airstamp",
						"short": "Air timestamp",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "airtime",
						"short": "Air time",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "id",
						"short": "Unique episode identifier",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "image",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "links",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "name",
						"short": "Episode name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "number",
						"short": "Episode number in season",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "rating",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "runtime",
						"short": "Runtime in minutes",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "season",
						"short": "Season number",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "show",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "summary",
						"short": "HTML summary",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"short": "Episode type (e.g., regular, significant_special)",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "url",
						"short": "TVmaze URL for the episode",
						"type": "`$STRING`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "scheduled_episode",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "country",
											"orig": "country",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "date",
											"orig": "date",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/schedule/web",
								"segments": []any{
									map[string]any{
										"lit": "schedule",
									},
									map[string]any{
										"lit": "web",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"country",
										"date",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"schedule",
									"web",
								},
							},
							map[string]any{
								"args": map[string]any{},
								"kind": "http",
								"method": "GET",
								"orig": "/schedule/full",
								"segments": []any{
									map[string]any{
										"lit": "schedule",
									},
									map[string]any{
										"lit": "full",
									},
								},
								"select": map[string]any{},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"schedule",
									"full",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"search": map[string]any{
				"fields": []any{},
				"name": "search",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "imdb",
											"orig": "imdb",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "thetvdb",
											"orig": "thetvdb",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "tvrage",
											"orig": "tvrage",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/lookup/shows",
								"segments": []any{
									map[string]any{
										"lit": "lookup",
									},
									map[string]any{
										"lit": "shows",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"imdb",
										"thetvdb",
										"tvrage",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"lookup",
									"shows",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
			"season": map[string]any{
				"fields": []any{
					map[string]any{
						"format": "date",
						"name": "endDate",
						"short": "End date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "episodeOrder",
						"short": "Number of episodes",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "id",
						"short": "Unique season identifier",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "image",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "links",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "name",
						"short": "Season name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "network",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "number",
						"short": "Season number",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"format": "date",
						"name": "premiereDate",
						"short": "Premiere date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "summary",
						"short": "HTML summary",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "url",
						"short": "TVmaze URL for the season",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "webChannel",
						"type": "`$OBJECT`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "season",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "show_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/shows/{id}/seasons",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "show_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "shows",
									},
									map[string]any{
										"var": "show_id",
									},
									map[string]any{
										"lit": "seasons",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"show_id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"shows",
									"{show_id}",
									"seasons",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"show",
						},
					},
				},
			},
			"show": map[string]any{
				"fields": []any{
					map[string]any{
						"name": "averageRuntime",
						"short": "Average runtime in minutes",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "dvdCountry",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"format": "date",
						"name": "ended",
						"short": "End date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "externals",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "genres",
						"short": "List of genres",
						"type": "`$ARRAY`",
					},
					map[string]any{
						"name": "id",
						"short": "Unique show identifier",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "image",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "language",
						"short": "Original language",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "links",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "name",
						"short": "Show name",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "network",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "officialSite",
						"short": "Official website URL",
						"type": "`$STRING`",
					},
					map[string]any{
						"format": "date",
						"name": "premiered",
						"short": "Premiere date",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "rating",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "runtime",
						"short": "Runtime in minutes",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "schedule",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "score",
						"short": "Search relevancy score",
						"type": "`$NUMBER`",
					},
					map[string]any{
						"name": "show",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "status",
						"short": "Current status (e.g., Running, Ended)",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "summary",
						"short": "HTML summary",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "type",
						"short": "Show type (e.g., Scripted, Reality)",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "updated",
						"short": "Unix timestamp of last update",
						"type": "`$INTEGER`",
					},
					map[string]any{
						"name": "url",
						"short": "TVmaze URL for the show",
						"type": "`$STRING`",
					},
					map[string]any{
						"name": "webChannel",
						"type": "`$OBJECT`",
					},
					map[string]any{
						"name": "weight",
						"short": "Show weight/importance",
						"type": "`$INTEGER`",
					},
				},
				"id": map[string]any{
					"field": "id",
					"name": "id",
				},
				"name": "show",
				"op": map[string]any{
					"list": map[string]any{
						"input": "data",
						"name": "list",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "alternatelist_id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "embed",
											"orig": "embed",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/alternatelists/{id}/alternateepisodes",
								"rename": map[string]any{
									"param": map[string]any{
										"id": "alternatelist_id",
									},
								},
								"segments": []any{
									map[string]any{
										"lit": "alternatelists",
									},
									map[string]any{
										"var": "alternatelist_id",
									},
									map[string]any{
										"lit": "alternateepisodes",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"alternatelist_id",
										"embed",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"alternatelists",
									"{alternatelist_id}",
									"alternateepisodes",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "embed",
											"orig": "embed",
											"type": "`$STRING`",
										},
										map[string]any{
											"kind": "query",
											"name": "q",
											"orig": "q",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/singlesearch/shows",
								"segments": []any{
									map[string]any{
										"lit": "singlesearch",
									},
									map[string]any{
										"lit": "shows",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"embed",
										"q",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"singlesearch",
									"shows",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"example": 0,
											"kind": "query",
											"name": "page",
											"orig": "page",
											"type": "`$INTEGER`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/shows",
								"segments": []any{
									map[string]any{
										"lit": "shows",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"page",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"shows",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "q",
											"orig": "q",
											"reqd": true,
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/search/shows",
								"segments": []any{
									map[string]any{
										"lit": "search",
									},
									map[string]any{
										"lit": "shows",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"q",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"search",
									"shows",
								},
							},
						},
					},
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"params": []any{
										map[string]any{
											"kind": "param",
											"name": "id",
											"orig": "id",
											"reqd": true,
											"type": "`$INTEGER`",
										},
									},
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "embed",
											"orig": "embed",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/shows/{id}",
								"segments": []any{
									map[string]any{
										"lit": "shows",
									},
									map[string]any{
										"var": "id",
									},
								},
								"select": map[string]any{
									"exist": []any{
										"embed",
										"id",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"shows",
									"{id}",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{
						[]any{
							"alternatelist",
						},
					},
				},
			},
			"update": map[string]any{
				"fields": []any{},
				"name": "update",
				"op": map[string]any{
					"load": map[string]any{
						"input": "data",
						"name": "load",
						"points": []any{
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "since",
											"orig": "since",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/updates/people",
								"segments": []any{
									map[string]any{
										"lit": "updates",
									},
									map[string]any{
										"lit": "people",
									},
								},
								"select": map[string]any{
									"$action": "person",
									"exist": []any{
										"since",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"updates",
									"people",
								},
							},
							map[string]any{
								"args": map[string]any{
									"query": []any{
										map[string]any{
											"kind": "query",
											"name": "since",
											"orig": "since",
											"type": "`$STRING`",
										},
									},
								},
								"kind": "http",
								"method": "GET",
								"orig": "/updates/shows",
								"segments": []any{
									map[string]any{
										"lit": "updates",
									},
									map[string]any{
										"lit": "shows",
									},
								},
								"select": map[string]any{
									"$action": "show",
									"exist": []any{
										"since",
									},
								},
								"transform": map[string]any{
									"req": "`reqdata`",
									"res": "`body`",
								},
								"parts": []any{
									"updates",
									"shows",
								},
							},
						},
					},
				},
				"relations": map[string]any{
					"ancestors": []any{},
				},
			},
		},
	}
}

// The plugin definitions the model selected per feature, as []any so a
// feature package can consume them without core naming its types. Empty
// when no active feature declares active plugin groups for this target.
var featurePlugins = map[string][]any{
}

// FeaturePlugins is the definitions list for one feature's chain.
func FeaturePlugins(name string) []any {
	return featurePlugins[name]
}

var (
	sharedConfigOnce sync.Once
	sharedConfigVal  map[string]any
)

// SharedConfig returns the process-wide config, built once on first use.
// The SDK reads the config on every request and never writes to it, so one
// instance is shared by every client rather than rebuilt per client.
//
// The returned map is shared: treat it as read-only. Callers that need to
// mutate should use MakeConfig, which always returns a fresh copy.
func SharedConfig() map[string]any {
	sharedConfigOnce.Do(func() {
		sharedConfigVal = MakeConfig()
	})
	return sharedConfigVal
}

func makeFeature(name string) Feature {
	switch name {
	case "test":
		if NewTestFeatureFunc != nil {
			return NewTestFeatureFunc()
		}
	default:
		if NewBaseFeatureFunc != nil {
			return NewBaseFeatureFunc()
		}
	}
	return nil
}
