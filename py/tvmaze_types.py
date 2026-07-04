# Typed models for the Tvmaze SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Field/param types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Do not edit by hand.

from __future__ import annotations

from dataclasses import dataclass
from typing import Optional, Any


@dataclass
class Aka:
    country: Optional[dict] = None
    name: Optional[str] = None


@dataclass
class AkaListMatch:
    show_id: int


@dataclass
class AlternateList:
    id: Optional[int] = None
    link: Optional[dict] = None
    name: Optional[str] = None
    url: Optional[str] = None


@dataclass
class AlternateListLoadMatch:
    id: int


@dataclass
class AlternateListListMatch:
    show_id: int


@dataclass
class Cast:
    character: Optional[dict] = None
    person: Optional[dict] = None
    self: Optional[bool] = None
    voice: Optional[bool] = None


@dataclass
class CastListMatch:
    show_id: int


@dataclass
class CastCredit:
    link: Optional[dict] = None


@dataclass
class CastCreditListMatch:
    person_id: int


@dataclass
class CastMember:
    character: Optional[dict] = None
    person: Optional[dict] = None
    self: Optional[bool] = None
    voice: Optional[bool] = None


@dataclass
class CastMemberListMatch:
    episode_id: int


@dataclass
class Crew:
    person: Optional[dict] = None
    type: Optional[str] = None


@dataclass
class CrewListMatch:
    show_id: int


@dataclass
class CrewCredit:
    link: Optional[dict] = None
    type: Optional[str] = None


@dataclass
class CrewCreditListMatch:
    person_id: int


@dataclass
class CrewMember:
    person: Optional[dict] = None
    type: Optional[str] = None


@dataclass
class CrewMemberListMatch:
    episode_id: int


@dataclass
class Episode:
    airdate: Optional[str] = None
    airstamp: Optional[str] = None
    airtime: Optional[str] = None
    id: Optional[int] = None
    image: Optional[dict] = None
    link: Optional[dict] = None
    name: Optional[str] = None
    number: Optional[int] = None
    rating: Optional[dict] = None
    runtime: Optional[int] = None
    season: Optional[int] = None
    summary: Optional[str] = None
    type: Optional[str] = None
    url: Optional[str] = None


@dataclass
class EpisodeLoadMatch:
    show_id: int
    id: int


@dataclass
class EpisodeListMatch:
    show_id: int
    season_id: int


@dataclass
class GuestCastCredit:
    link: Optional[dict] = None


@dataclass
class GuestCastCreditListMatch:
    person_id: int


@dataclass
class Image:
    id: Optional[int] = None
    main: Optional[bool] = None
    resolution: Optional[dict] = None
    type: Optional[str] = None


@dataclass
class ImageListMatch:
    show_id: int


@dataclass
class Person:
    birthday: Optional[str] = None
    country: Optional[dict] = None
    deathday: Optional[str] = None
    gender: Optional[str] = None
    id: Optional[int] = None
    image: Optional[dict] = None
    link: Optional[dict] = None
    name: Optional[str] = None
    person: Optional[dict] = None
    score: Optional[float] = None
    updated: Optional[int] = None
    url: Optional[str] = None


@dataclass
class PersonLoadMatch:
    id: int


@dataclass
class PersonListMatch:
    birthday: Optional[str] = None
    country: Optional[dict] = None
    deathday: Optional[str] = None
    gender: Optional[str] = None
    id: Optional[int] = None
    image: Optional[dict] = None
    link: Optional[dict] = None
    name: Optional[str] = None
    person: Optional[dict] = None
    score: Optional[float] = None
    updated: Optional[int] = None
    url: Optional[str] = None


@dataclass
class Schedule:
    airdate: Optional[str] = None
    airstamp: Optional[str] = None
    airtime: Optional[str] = None
    id: Optional[int] = None
    image: Optional[dict] = None
    link: Optional[dict] = None
    name: Optional[str] = None
    number: Optional[int] = None
    rating: Optional[dict] = None
    runtime: Optional[int] = None
    season: Optional[int] = None
    show: Optional[dict] = None
    summary: Optional[str] = None
    type: Optional[str] = None
    url: Optional[str] = None


@dataclass
class ScheduleListMatch:
    airdate: Optional[str] = None
    airstamp: Optional[str] = None
    airtime: Optional[str] = None
    id: Optional[int] = None
    image: Optional[dict] = None
    link: Optional[dict] = None
    name: Optional[str] = None
    number: Optional[int] = None
    rating: Optional[dict] = None
    runtime: Optional[int] = None
    season: Optional[int] = None
    show: Optional[dict] = None
    summary: Optional[str] = None
    type: Optional[str] = None
    url: Optional[str] = None


@dataclass
class ScheduledEpisode:
    airdate: Optional[str] = None
    airstamp: Optional[str] = None
    airtime: Optional[str] = None
    id: Optional[int] = None
    image: Optional[dict] = None
    link: Optional[dict] = None
    name: Optional[str] = None
    number: Optional[int] = None
    rating: Optional[dict] = None
    runtime: Optional[int] = None
    season: Optional[int] = None
    show: Optional[dict] = None
    summary: Optional[str] = None
    type: Optional[str] = None
    url: Optional[str] = None


@dataclass
class ScheduledEpisodeListMatch:
    airdate: Optional[str] = None
    airstamp: Optional[str] = None
    airtime: Optional[str] = None
    id: Optional[int] = None
    image: Optional[dict] = None
    link: Optional[dict] = None
    name: Optional[str] = None
    number: Optional[int] = None
    rating: Optional[dict] = None
    runtime: Optional[int] = None
    season: Optional[int] = None
    show: Optional[dict] = None
    summary: Optional[str] = None
    type: Optional[str] = None
    url: Optional[str] = None


@dataclass
class Search:
    pass


@dataclass
class SearchLoadMatch:
    pass


@dataclass
class Season:
    end_date: Optional[str] = None
    episode_order: Optional[int] = None
    id: Optional[int] = None
    image: Optional[dict] = None
    link: Optional[dict] = None
    name: Optional[str] = None
    network: Optional[dict] = None
    number: Optional[int] = None
    premiere_date: Optional[str] = None
    summary: Optional[str] = None
    url: Optional[str] = None
    web_channel: Optional[dict] = None


@dataclass
class SeasonListMatch:
    show_id: int


@dataclass
class Show:
    average_runtime: Optional[int] = None
    dvd_country: Optional[dict] = None
    ended: Optional[str] = None
    external: Optional[dict] = None
    genre: Optional[list] = None
    id: Optional[int] = None
    image: Optional[dict] = None
    language: Optional[str] = None
    link: Optional[dict] = None
    name: Optional[str] = None
    network: Optional[dict] = None
    official_site: Optional[str] = None
    premiered: Optional[str] = None
    rating: Optional[dict] = None
    runtime: Optional[int] = None
    schedule: Optional[dict] = None
    score: Optional[float] = None
    show: Optional[dict] = None
    status: Optional[str] = None
    summary: Optional[str] = None
    type: Optional[str] = None
    updated: Optional[int] = None
    url: Optional[str] = None
    web_channel: Optional[dict] = None
    weight: Optional[int] = None


@dataclass
class ShowLoadMatch:
    id: int


@dataclass
class ShowListMatch:
    alternatelist_id: int


@dataclass
class Update:
    pass


@dataclass
class UpdateLoadMatch:
    pass

