# Typed models for the Tvmaze SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.
#
# These are TypedDicts, not dataclasses: the SDK ops return/accept plain dicts
# at runtime, and a TypedDict IS a dict shape, so the types match the runtime.
# Optional (req:false) keys are modelled as TypedDict key-optionality
# (total=False), split into a required base + total=False subclass when a type
# has both required and optional keys.

from __future__ import annotations

from typing import TypedDict, Any


class Aka(TypedDict, total=False):
    country: dict
    name: str


class AkaListMatch(TypedDict):
    show_id: int


class AlternateList(TypedDict, total=False):
    id: int
    link: dict
    name: str
    url: str


class AlternateListLoadMatch(TypedDict):
    id: int


class AlternateListListMatch(TypedDict):
    show_id: int


class Cast(TypedDict, total=False):
    character: dict
    person: dict
    self: bool
    voice: bool


class CastListMatch(TypedDict):
    show_id: int


class CastCredit(TypedDict, total=False):
    link: dict


class CastCreditListMatch(TypedDict):
    person_id: int


class CastMember(TypedDict, total=False):
    character: dict
    person: dict
    self: bool
    voice: bool


class CastMemberListMatch(TypedDict):
    episode_id: int


class Crew(TypedDict, total=False):
    person: dict
    type: str


class CrewListMatch(TypedDict):
    show_id: int


class CrewCredit(TypedDict, total=False):
    link: dict
    type: str


class CrewCreditListMatch(TypedDict):
    person_id: int


class CrewMember(TypedDict, total=False):
    person: dict
    type: str


class CrewMemberListMatch(TypedDict):
    episode_id: int


class Episode(TypedDict, total=False):
    airdate: str
    airstamp: str
    airtime: str
    id: int
    image: dict
    link: dict
    name: str
    number: int
    rating: dict
    runtime: int
    season: int
    summary: str
    type: str
    url: str


class EpisodeLoadMatch(TypedDict):
    show_id: int
    id: int


class EpisodeListMatch(TypedDict):
    show_id: int
    season_id: int


class GuestCastCredit(TypedDict, total=False):
    link: dict


class GuestCastCreditListMatch(TypedDict):
    person_id: int


class Image(TypedDict, total=False):
    id: int
    main: bool
    resolution: dict
    type: str


class ImageListMatch(TypedDict):
    show_id: int


class Person(TypedDict, total=False):
    birthday: str
    country: dict
    deathday: str
    gender: str
    id: int
    image: dict
    link: dict
    name: str
    person: dict
    score: float
    updated: int
    url: str


class PersonLoadMatch(TypedDict):
    id: int


class PersonListMatch(TypedDict, total=False):
    birthday: str
    country: dict
    deathday: str
    gender: str
    id: int
    image: dict
    link: dict
    name: str
    person: dict
    score: float
    updated: int
    url: str


class Schedule(TypedDict, total=False):
    airdate: str
    airstamp: str
    airtime: str
    id: int
    image: dict
    link: dict
    name: str
    number: int
    rating: dict
    runtime: int
    season: int
    show: dict
    summary: str
    type: str
    url: str


class ScheduleListMatch(TypedDict, total=False):
    airdate: str
    airstamp: str
    airtime: str
    id: int
    image: dict
    link: dict
    name: str
    number: int
    rating: dict
    runtime: int
    season: int
    show: dict
    summary: str
    type: str
    url: str


class ScheduledEpisode(TypedDict, total=False):
    airdate: str
    airstamp: str
    airtime: str
    id: int
    image: dict
    link: dict
    name: str
    number: int
    rating: dict
    runtime: int
    season: int
    show: dict
    summary: str
    type: str
    url: str


class ScheduledEpisodeListMatch(TypedDict, total=False):
    airdate: str
    airstamp: str
    airtime: str
    id: int
    image: dict
    link: dict
    name: str
    number: int
    rating: dict
    runtime: int
    season: int
    show: dict
    summary: str
    type: str
    url: str


class Search(TypedDict):
    pass


class SearchLoadMatch(TypedDict):
    pass


class Season(TypedDict, total=False):
    end_date: str
    episode_order: int
    id: int
    image: dict
    link: dict
    name: str
    network: dict
    number: int
    premiere_date: str
    summary: str
    url: str
    web_channel: dict


class SeasonListMatch(TypedDict):
    show_id: int


class Show(TypedDict, total=False):
    average_runtime: int
    dvd_country: dict
    ended: str
    external: dict
    genre: list
    id: int
    image: dict
    language: str
    link: dict
    name: str
    network: dict
    official_site: str
    premiered: str
    rating: dict
    runtime: int
    schedule: dict
    score: float
    show: dict
    status: str
    summary: str
    type: str
    updated: int
    url: str
    web_channel: dict
    weight: int


class ShowLoadMatch(TypedDict):
    id: int


class ShowListMatch(TypedDict):
    alternatelist_id: int


class Update(TypedDict):
    pass


class UpdateLoadMatch(TypedDict):
    pass
