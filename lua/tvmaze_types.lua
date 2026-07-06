-- Typed models for the Tvmaze SDK (LuaLS annotations).
--
-- GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
-- params (op.<name>.points[].args.params[]). Field/param types come from the
-- canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
-- @voxgig/apidef VALID_CANON). Annotations only — no runtime effect. Do not
-- edit by hand.

---@class Aka
---@field country? table
---@field name? string

---@class AkaListMatch
---@field show_id number

---@class AlternateList
---@field id? number
---@field link? table
---@field name? string
---@field url? string

---@class AlternateListLoadMatch
---@field id number

---@class AlternateListListMatch
---@field show_id number

---@class Cast
---@field character? table
---@field person? table
---@field self? boolean
---@field voice? boolean

---@class CastListMatch
---@field show_id number

---@class CastCredit
---@field link? table

---@class CastCreditListMatch
---@field person_id number

---@class CastMember
---@field character? table
---@field person? table
---@field self? boolean
---@field voice? boolean

---@class CastMemberListMatch
---@field episode_id number

---@class Crew
---@field person? table
---@field type? string

---@class CrewListMatch
---@field show_id number

---@class CrewCredit
---@field link? table
---@field type? string

---@class CrewCreditListMatch
---@field person_id number

---@class CrewMember
---@field person? table
---@field type? string

---@class CrewMemberListMatch
---@field episode_id number

---@class Episode
---@field airdate? string
---@field airstamp? string
---@field airtime? string
---@field id? number
---@field image? table
---@field link? table
---@field name? string
---@field number? number
---@field rating? table
---@field runtime? number
---@field season? number
---@field summary? string
---@field type? string
---@field url? string

---@class EpisodeLoadMatch
---@field show_id number
---@field id number

---@class EpisodeListMatch
---@field show_id number
---@field season_id number

---@class GuestCastCredit
---@field link? table

---@class GuestCastCreditListMatch
---@field person_id number

---@class Image
---@field id? number
---@field main? boolean
---@field resolution? table
---@field type? string

---@class ImageListMatch
---@field show_id number

---@class Person
---@field birthday? string
---@field country? table
---@field deathday? string
---@field gender? string
---@field id? number
---@field image? table
---@field link? table
---@field name? string
---@field person? table
---@field score? number
---@field updated? number
---@field url? string

---@class PersonLoadMatch
---@field id number

---@class PersonListMatch
---@field birthday? string
---@field country? table
---@field deathday? string
---@field gender? string
---@field id? number
---@field image? table
---@field link? table
---@field name? string
---@field person? table
---@field score? number
---@field updated? number
---@field url? string

---@class Schedule
---@field airdate? string
---@field airstamp? string
---@field airtime? string
---@field id? number
---@field image? table
---@field link? table
---@field name? string
---@field number? number
---@field rating? table
---@field runtime? number
---@field season? number
---@field show? table
---@field summary? string
---@field type? string
---@field url? string

---@class ScheduleListMatch
---@field airdate? string
---@field airstamp? string
---@field airtime? string
---@field id? number
---@field image? table
---@field link? table
---@field name? string
---@field number? number
---@field rating? table
---@field runtime? number
---@field season? number
---@field show? table
---@field summary? string
---@field type? string
---@field url? string

---@class ScheduledEpisode
---@field airdate? string
---@field airstamp? string
---@field airtime? string
---@field id? number
---@field image? table
---@field link? table
---@field name? string
---@field number? number
---@field rating? table
---@field runtime? number
---@field season? number
---@field show? table
---@field summary? string
---@field type? string
---@field url? string

---@class ScheduledEpisodeListMatch
---@field airdate? string
---@field airstamp? string
---@field airtime? string
---@field id? number
---@field image? table
---@field link? table
---@field name? string
---@field number? number
---@field rating? table
---@field runtime? number
---@field season? number
---@field show? table
---@field summary? string
---@field type? string
---@field url? string

---@class Search

---@class SearchLoadMatch

---@class Season
---@field end_date? string
---@field episode_order? number
---@field id? number
---@field image? table
---@field link? table
---@field name? string
---@field network? table
---@field number? number
---@field premiere_date? string
---@field summary? string
---@field url? string
---@field web_channel? table

---@class SeasonListMatch
---@field show_id number

---@class Show
---@field average_runtime? number
---@field dvd_country? table
---@field ended? string
---@field external? table
---@field genre? table
---@field id? number
---@field image? table
---@field language? string
---@field link? table
---@field name? string
---@field network? table
---@field official_site? string
---@field premiered? string
---@field rating? table
---@field runtime? number
---@field schedule? table
---@field score? number
---@field show? table
---@field status? string
---@field summary? string
---@field type? string
---@field updated? number
---@field url? string
---@field web_channel? table
---@field weight? number

---@class ShowLoadMatch
---@field id number

---@class ShowListMatch
---@field alternatelist_id number

---@class Update

---@class UpdateLoadMatch

local M = {}

return M
