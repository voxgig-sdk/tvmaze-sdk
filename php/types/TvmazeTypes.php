<?php
declare(strict_types=1);

// Typed models for the Tvmaze SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
//
// These are documentation-grade value objects (PHP 8 typed properties),
// registered on the composer classmap autoload. The SDK boundary exchanges
// assoc-arrays; these classes name the shapes for tooling and typed callers.

/** Aka entity data model. */
class Aka
{
    public ?array $country = null;
    public ?string $name = null;
}

/** Request payload for Aka#list. */
class AkaListMatch
{
    public int $show_id;
}

/** AlternateList entity data model. */
class AlternateList
{
    public ?int $id = null;
    public ?array $link = null;
    public ?string $name = null;
    public ?string $url = null;
}

/** Request payload for AlternateList#load. */
class AlternateListLoadMatch
{
    public int $id;
}

/** Request payload for AlternateList#list. */
class AlternateListListMatch
{
    public int $show_id;
}

/** Cast entity data model. */
class Cast
{
    public ?array $character = null;
    public ?array $person = null;
    public ?bool $self = null;
    public ?bool $voice = null;
}

/** Request payload for Cast#list. */
class CastListMatch
{
    public int $show_id;
}

/** CastCredit entity data model. */
class CastCredit
{
    public ?array $link = null;
}

/** Request payload for CastCredit#list. */
class CastCreditListMatch
{
    public int $person_id;
}

/** CastMember entity data model. */
class CastMember
{
    public ?array $character = null;
    public ?array $person = null;
    public ?bool $self = null;
    public ?bool $voice = null;
}

/** Request payload for CastMember#list. */
class CastMemberListMatch
{
    public int $episode_id;
}

/** Crew entity data model. */
class Crew
{
    public ?array $person = null;
    public ?string $type = null;
}

/** Request payload for Crew#list. */
class CrewListMatch
{
    public int $show_id;
}

/** CrewCredit entity data model. */
class CrewCredit
{
    public ?array $link = null;
    public ?string $type = null;
}

/** Request payload for CrewCredit#list. */
class CrewCreditListMatch
{
    public int $person_id;
}

/** CrewMember entity data model. */
class CrewMember
{
    public ?array $person = null;
    public ?string $type = null;
}

/** Request payload for CrewMember#list. */
class CrewMemberListMatch
{
    public int $episode_id;
}

/** Episode entity data model. */
class Episode
{
    public ?string $airdate = null;
    public ?string $airstamp = null;
    public ?string $airtime = null;
    public ?int $id = null;
    public ?array $image = null;
    public ?array $link = null;
    public ?string $name = null;
    public ?int $number = null;
    public ?array $rating = null;
    public ?int $runtime = null;
    public ?int $season = null;
    public ?string $summary = null;
    public ?string $type = null;
    public ?string $url = null;
}

/** Request payload for Episode#load. */
class EpisodeLoadMatch
{
    public int $show_id;
    public int $id;
}

/** Request payload for Episode#list. */
class EpisodeListMatch
{
    public int $show_id;
    public int $season_id;
}

/** GuestCastCredit entity data model. */
class GuestCastCredit
{
    public ?array $link = null;
}

/** Request payload for GuestCastCredit#list. */
class GuestCastCreditListMatch
{
    public int $person_id;
}

/** Image entity data model. */
class Image
{
    public ?int $id = null;
    public ?bool $main = null;
    public ?array $resolution = null;
    public ?string $type = null;
}

/** Request payload for Image#list. */
class ImageListMatch
{
    public int $show_id;
}

/** Person entity data model. */
class Person
{
    public ?string $birthday = null;
    public ?array $country = null;
    public ?string $deathday = null;
    public ?string $gender = null;
    public ?int $id = null;
    public ?array $image = null;
    public ?array $link = null;
    public ?string $name = null;
    public ?array $person = null;
    public ?float $score = null;
    public ?int $updated = null;
    public ?string $url = null;
}

/** Request payload for Person#load. */
class PersonLoadMatch
{
    public int $id;
}

/** Request payload for Person#list. */
class PersonListMatch
{
    public ?string $birthday = null;
    public ?array $country = null;
    public ?string $deathday = null;
    public ?string $gender = null;
    public ?int $id = null;
    public ?array $image = null;
    public ?array $link = null;
    public ?string $name = null;
    public ?array $person = null;
    public ?float $score = null;
    public ?int $updated = null;
    public ?string $url = null;
}

/** Schedule entity data model. */
class Schedule
{
    public ?string $airdate = null;
    public ?string $airstamp = null;
    public ?string $airtime = null;
    public ?int $id = null;
    public ?array $image = null;
    public ?array $link = null;
    public ?string $name = null;
    public ?int $number = null;
    public ?array $rating = null;
    public ?int $runtime = null;
    public ?int $season = null;
    public ?array $show = null;
    public ?string $summary = null;
    public ?string $type = null;
    public ?string $url = null;
}

/** Request payload for Schedule#list. */
class ScheduleListMatch
{
    public ?string $airdate = null;
    public ?string $airstamp = null;
    public ?string $airtime = null;
    public ?int $id = null;
    public ?array $image = null;
    public ?array $link = null;
    public ?string $name = null;
    public ?int $number = null;
    public ?array $rating = null;
    public ?int $runtime = null;
    public ?int $season = null;
    public ?array $show = null;
    public ?string $summary = null;
    public ?string $type = null;
    public ?string $url = null;
}

/** ScheduledEpisode entity data model. */
class ScheduledEpisode
{
    public ?string $airdate = null;
    public ?string $airstamp = null;
    public ?string $airtime = null;
    public ?int $id = null;
    public ?array $image = null;
    public ?array $link = null;
    public ?string $name = null;
    public ?int $number = null;
    public ?array $rating = null;
    public ?int $runtime = null;
    public ?int $season = null;
    public ?array $show = null;
    public ?string $summary = null;
    public ?string $type = null;
    public ?string $url = null;
}

/** Request payload for ScheduledEpisode#list. */
class ScheduledEpisodeListMatch
{
    public ?string $airdate = null;
    public ?string $airstamp = null;
    public ?string $airtime = null;
    public ?int $id = null;
    public ?array $image = null;
    public ?array $link = null;
    public ?string $name = null;
    public ?int $number = null;
    public ?array $rating = null;
    public ?int $runtime = null;
    public ?int $season = null;
    public ?array $show = null;
    public ?string $summary = null;
    public ?string $type = null;
    public ?string $url = null;
}

/** Search entity data model. */
class Search
{
}

/** Request payload for Search#load. */
class SearchLoadMatch
{
}

/** Season entity data model. */
class Season
{
    public ?string $end_date = null;
    public ?int $episode_order = null;
    public ?int $id = null;
    public ?array $image = null;
    public ?array $link = null;
    public ?string $name = null;
    public ?array $network = null;
    public ?int $number = null;
    public ?string $premiere_date = null;
    public ?string $summary = null;
    public ?string $url = null;
    public ?array $web_channel = null;
}

/** Request payload for Season#list. */
class SeasonListMatch
{
    public int $show_id;
}

/** Show entity data model. */
class Show
{
    public ?int $average_runtime = null;
    public ?array $dvd_country = null;
    public ?string $ended = null;
    public ?array $external = null;
    public ?array $genre = null;
    public ?int $id = null;
    public ?array $image = null;
    public ?string $language = null;
    public ?array $link = null;
    public ?string $name = null;
    public ?array $network = null;
    public ?string $official_site = null;
    public ?string $premiered = null;
    public ?array $rating = null;
    public ?int $runtime = null;
    public ?array $schedule = null;
    public ?float $score = null;
    public ?array $show = null;
    public ?string $status = null;
    public ?string $summary = null;
    public ?string $type = null;
    public ?int $updated = null;
    public ?string $url = null;
    public ?array $web_channel = null;
    public ?int $weight = null;
}

/** Request payload for Show#load. */
class ShowLoadMatch
{
    public int $id;
}

/** Request payload for Show#list. */
class ShowListMatch
{
    public int $alternatelist_id;
}

/** Update entity data model. */
class Update
{
}

/** Request payload for Update#load. */
class UpdateLoadMatch
{
}

