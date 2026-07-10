// Typed models for the Tvmaze SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.

export interface Aka {
  country?: Record<string, any>
  name?: string
}

export interface AkaListMatch {
  show_id: number
}

export interface AlternateList {
  id?: number
  link?: Record<string, any>
  name?: string
  url?: string
}

export interface AlternateListLoadMatch {
  id: number
}

export interface AlternateListListMatch {
  show_id: number
}

export interface Cast {
  character?: Record<string, any>
  person?: Record<string, any>
  self?: boolean
  voice?: boolean
}

export interface CastListMatch {
  show_id: number
}

export interface CastCredit {
  link?: Record<string, any>
}

export interface CastCreditListMatch {
  person_id: number
}

export interface CastMember {
  character?: Record<string, any>
  person?: Record<string, any>
  self?: boolean
  voice?: boolean
}

export interface CastMemberListMatch {
  episode_id: number
}

export interface Crew {
  person?: Record<string, any>
  type?: string
}

export interface CrewListMatch {
  show_id: number
}

export interface CrewCredit {
  link?: Record<string, any>
  type?: string
}

export interface CrewCreditListMatch {
  person_id: number
}

export interface CrewMember {
  person?: Record<string, any>
  type?: string
}

export interface CrewMemberListMatch {
  episode_id: number
}

export interface Episode {
  airdate?: string
  airstamp?: string
  airtime?: string
  id?: number
  image?: Record<string, any>
  link?: Record<string, any>
  name?: string
  number?: number
  rating?: Record<string, any>
  runtime?: number
  season?: number
  summary?: string
  type?: string
  url?: string
}

export interface EpisodeLoadMatch {
  show_id?: number
  id?: number
}

export interface EpisodeListMatch {
  show_id?: number
  season_id?: number
}

export interface GuestCastCredit {
  link?: Record<string, any>
}

export interface GuestCastCreditListMatch {
  person_id: number
}

export interface Image {
  id?: number
  main?: boolean
  resolution?: Record<string, any>
  type?: string
}

export interface ImageListMatch {
  show_id: number
}

export interface Person {
  birthday?: string
  country?: Record<string, any>
  deathday?: string
  gender?: string
  id?: number
  image?: Record<string, any>
  link?: Record<string, any>
  name?: string
  person?: Record<string, any>
  score?: number
  updated?: number
  url?: string
}

export interface PersonLoadMatch {
  id: number
}

export interface PersonListMatch {
  birthday?: string
  country?: Record<string, any>
  deathday?: string
  gender?: string
  id?: number
  image?: Record<string, any>
  link?: Record<string, any>
  name?: string
  person?: Record<string, any>
  score?: number
  updated?: number
  url?: string
}

export interface Schedule {
  airdate?: string
  airstamp?: string
  airtime?: string
  id?: number
  image?: Record<string, any>
  link?: Record<string, any>
  name?: string
  number?: number
  rating?: Record<string, any>
  runtime?: number
  season?: number
  show?: Record<string, any>
  summary?: string
  type?: string
  url?: string
}

export interface ScheduleListMatch {
  airdate?: string
  airstamp?: string
  airtime?: string
  id?: number
  image?: Record<string, any>
  link?: Record<string, any>
  name?: string
  number?: number
  rating?: Record<string, any>
  runtime?: number
  season?: number
  show?: Record<string, any>
  summary?: string
  type?: string
  url?: string
}

export interface ScheduledEpisode {
  airdate?: string
  airstamp?: string
  airtime?: string
  id?: number
  image?: Record<string, any>
  link?: Record<string, any>
  name?: string
  number?: number
  rating?: Record<string, any>
  runtime?: number
  season?: number
  show?: Record<string, any>
  summary?: string
  type?: string
  url?: string
}

export interface ScheduledEpisodeListMatch {
  airdate?: string
  airstamp?: string
  airtime?: string
  id?: number
  image?: Record<string, any>
  link?: Record<string, any>
  name?: string
  number?: number
  rating?: Record<string, any>
  runtime?: number
  season?: number
  show?: Record<string, any>
  summary?: string
  type?: string
  url?: string
}

export interface Search {
}

export interface SearchLoadMatch {
}

export interface Season {
  end_date?: string
  episode_order?: number
  id?: number
  image?: Record<string, any>
  link?: Record<string, any>
  name?: string
  network?: Record<string, any>
  number?: number
  premiere_date?: string
  summary?: string
  url?: string
  web_channel?: Record<string, any>
}

export interface SeasonListMatch {
  show_id: number
}

export interface Show {
  average_runtime?: number
  dvd_country?: Record<string, any>
  ended?: string
  external?: Record<string, any>
  genre?: any[]
  id?: number
  image?: Record<string, any>
  language?: string
  link?: Record<string, any>
  name?: string
  network?: Record<string, any>
  official_site?: string
  premiered?: string
  rating?: Record<string, any>
  runtime?: number
  schedule?: Record<string, any>
  score?: number
  show?: Record<string, any>
  status?: string
  summary?: string
  type?: string
  updated?: number
  url?: string
  web_channel?: Record<string, any>
  weight?: number
}

export interface ShowLoadMatch {
  id: number
}

export interface ShowListMatch {
  alternatelist_id?: number
}

export interface Update {
}

export interface UpdateLoadMatch {
}

