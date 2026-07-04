// Typed models for the Tvmaze SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import "encoding/json"

// Aka is the typed data model for the aka entity.
type Aka struct {
	Country *map[string]any `json:"country,omitempty"`
	Name *string `json:"name,omitempty"`
}

// AkaListMatch is the typed request payload for Aka.ListTyped.
type AkaListMatch struct {
	ShowId int `json:"show_id"`
}

// AlternateList is the typed data model for the alternate_list entity.
type AlternateList struct {
	Id *int `json:"id,omitempty"`
	Link *map[string]any `json:"link,omitempty"`
	Name *string `json:"name,omitempty"`
	Url *string `json:"url,omitempty"`
}

// AlternateListLoadMatch is the typed request payload for AlternateList.LoadTyped.
type AlternateListLoadMatch struct {
	Id int `json:"id"`
}

// AlternateListListMatch is the typed request payload for AlternateList.ListTyped.
type AlternateListListMatch struct {
	ShowId int `json:"show_id"`
}

// Cast is the typed data model for the cast entity.
type Cast struct {
	Character *map[string]any `json:"character,omitempty"`
	Person *map[string]any `json:"person,omitempty"`
	Self *bool `json:"self,omitempty"`
	Voice *bool `json:"voice,omitempty"`
}

// CastListMatch is the typed request payload for Cast.ListTyped.
type CastListMatch struct {
	ShowId int `json:"show_id"`
}

// CastCredit is the typed data model for the cast_credit entity.
type CastCredit struct {
	Link *map[string]any `json:"link,omitempty"`
}

// CastCreditListMatch is the typed request payload for CastCredit.ListTyped.
type CastCreditListMatch struct {
	PersonId int `json:"person_id"`
}

// CastMember is the typed data model for the cast_member entity.
type CastMember struct {
	Character *map[string]any `json:"character,omitempty"`
	Person *map[string]any `json:"person,omitempty"`
	Self *bool `json:"self,omitempty"`
	Voice *bool `json:"voice,omitempty"`
}

// CastMemberListMatch is the typed request payload for CastMember.ListTyped.
type CastMemberListMatch struct {
	EpisodeId int `json:"episode_id"`
}

// Crew is the typed data model for the crew entity.
type Crew struct {
	Person *map[string]any `json:"person,omitempty"`
	Type *string `json:"type,omitempty"`
}

// CrewListMatch is the typed request payload for Crew.ListTyped.
type CrewListMatch struct {
	ShowId int `json:"show_id"`
}

// CrewCredit is the typed data model for the crew_credit entity.
type CrewCredit struct {
	Link *map[string]any `json:"link,omitempty"`
	Type *string `json:"type,omitempty"`
}

// CrewCreditListMatch is the typed request payload for CrewCredit.ListTyped.
type CrewCreditListMatch struct {
	PersonId int `json:"person_id"`
}

// CrewMember is the typed data model for the crew_member entity.
type CrewMember struct {
	Person *map[string]any `json:"person,omitempty"`
	Type *string `json:"type,omitempty"`
}

// CrewMemberListMatch is the typed request payload for CrewMember.ListTyped.
type CrewMemberListMatch struct {
	EpisodeId int `json:"episode_id"`
}

// Episode is the typed data model for the episode entity.
type Episode struct {
	Airdate *string `json:"airdate,omitempty"`
	Airstamp *string `json:"airstamp,omitempty"`
	Airtime *string `json:"airtime,omitempty"`
	Id *int `json:"id,omitempty"`
	Image *map[string]any `json:"image,omitempty"`
	Link *map[string]any `json:"link,omitempty"`
	Name *string `json:"name,omitempty"`
	Number *int `json:"number,omitempty"`
	Rating *map[string]any `json:"rating,omitempty"`
	Runtime *int `json:"runtime,omitempty"`
	Season *int `json:"season,omitempty"`
	Summary *string `json:"summary,omitempty"`
	Type *string `json:"type,omitempty"`
	Url *string `json:"url,omitempty"`
}

// EpisodeLoadMatch is the typed request payload for Episode.LoadTyped.
type EpisodeLoadMatch struct {
	ShowId int `json:"show_id"`
	Id int `json:"id"`
}

// EpisodeListMatch is the typed request payload for Episode.ListTyped.
type EpisodeListMatch struct {
	ShowId int `json:"show_id"`
	SeasonId int `json:"season_id"`
}

// GuestCastCredit is the typed data model for the guest_cast_credit entity.
type GuestCastCredit struct {
	Link *map[string]any `json:"link,omitempty"`
}

// GuestCastCreditListMatch is the typed request payload for GuestCastCredit.ListTyped.
type GuestCastCreditListMatch struct {
	PersonId int `json:"person_id"`
}

// Image is the typed data model for the image entity.
type Image struct {
	Id *int `json:"id,omitempty"`
	Main *bool `json:"main,omitempty"`
	Resolution *map[string]any `json:"resolution,omitempty"`
	Type *string `json:"type,omitempty"`
}

// ImageListMatch is the typed request payload for Image.ListTyped.
type ImageListMatch struct {
	ShowId int `json:"show_id"`
}

// Person is the typed data model for the person entity.
type Person struct {
	Birthday *string `json:"birthday,omitempty"`
	Country *map[string]any `json:"country,omitempty"`
	Deathday *string `json:"deathday,omitempty"`
	Gender *string `json:"gender,omitempty"`
	Id *int `json:"id,omitempty"`
	Image *map[string]any `json:"image,omitempty"`
	Link *map[string]any `json:"link,omitempty"`
	Name *string `json:"name,omitempty"`
	Person *map[string]any `json:"person,omitempty"`
	Score *float64 `json:"score,omitempty"`
	Updated *int `json:"updated,omitempty"`
	Url *string `json:"url,omitempty"`
}

// PersonLoadMatch is the typed request payload for Person.LoadTyped.
type PersonLoadMatch struct {
	Id int `json:"id"`
}

// PersonListMatch mirrors the person fields as an all-optional match
// filter (Go analog of Partial<Person>).
type PersonListMatch struct {
	Birthday *string `json:"birthday,omitempty"`
	Country *map[string]any `json:"country,omitempty"`
	Deathday *string `json:"deathday,omitempty"`
	Gender *string `json:"gender,omitempty"`
	Id *int `json:"id,omitempty"`
	Image *map[string]any `json:"image,omitempty"`
	Link *map[string]any `json:"link,omitempty"`
	Name *string `json:"name,omitempty"`
	Person *map[string]any `json:"person,omitempty"`
	Score *float64 `json:"score,omitempty"`
	Updated *int `json:"updated,omitempty"`
	Url *string `json:"url,omitempty"`
}

// Schedule is the typed data model for the schedule entity.
type Schedule struct {
	Airdate *string `json:"airdate,omitempty"`
	Airstamp *string `json:"airstamp,omitempty"`
	Airtime *string `json:"airtime,omitempty"`
	Id *int `json:"id,omitempty"`
	Image *map[string]any `json:"image,omitempty"`
	Link *map[string]any `json:"link,omitempty"`
	Name *string `json:"name,omitempty"`
	Number *int `json:"number,omitempty"`
	Rating *map[string]any `json:"rating,omitempty"`
	Runtime *int `json:"runtime,omitempty"`
	Season *int `json:"season,omitempty"`
	Show *map[string]any `json:"show,omitempty"`
	Summary *string `json:"summary,omitempty"`
	Type *string `json:"type,omitempty"`
	Url *string `json:"url,omitempty"`
}

// ScheduleListMatch mirrors the schedule fields as an all-optional match
// filter (Go analog of Partial<Schedule>).
type ScheduleListMatch struct {
	Airdate *string `json:"airdate,omitempty"`
	Airstamp *string `json:"airstamp,omitempty"`
	Airtime *string `json:"airtime,omitempty"`
	Id *int `json:"id,omitempty"`
	Image *map[string]any `json:"image,omitempty"`
	Link *map[string]any `json:"link,omitempty"`
	Name *string `json:"name,omitempty"`
	Number *int `json:"number,omitempty"`
	Rating *map[string]any `json:"rating,omitempty"`
	Runtime *int `json:"runtime,omitempty"`
	Season *int `json:"season,omitempty"`
	Show *map[string]any `json:"show,omitempty"`
	Summary *string `json:"summary,omitempty"`
	Type *string `json:"type,omitempty"`
	Url *string `json:"url,omitempty"`
}

// ScheduledEpisode is the typed data model for the scheduled_episode entity.
type ScheduledEpisode struct {
	Airdate *string `json:"airdate,omitempty"`
	Airstamp *string `json:"airstamp,omitempty"`
	Airtime *string `json:"airtime,omitempty"`
	Id *int `json:"id,omitempty"`
	Image *map[string]any `json:"image,omitempty"`
	Link *map[string]any `json:"link,omitempty"`
	Name *string `json:"name,omitempty"`
	Number *int `json:"number,omitempty"`
	Rating *map[string]any `json:"rating,omitempty"`
	Runtime *int `json:"runtime,omitempty"`
	Season *int `json:"season,omitempty"`
	Show *map[string]any `json:"show,omitempty"`
	Summary *string `json:"summary,omitempty"`
	Type *string `json:"type,omitempty"`
	Url *string `json:"url,omitempty"`
}

// ScheduledEpisodeListMatch mirrors the scheduled_episode fields as an all-optional match
// filter (Go analog of Partial<ScheduledEpisode>).
type ScheduledEpisodeListMatch struct {
	Airdate *string `json:"airdate,omitempty"`
	Airstamp *string `json:"airstamp,omitempty"`
	Airtime *string `json:"airtime,omitempty"`
	Id *int `json:"id,omitempty"`
	Image *map[string]any `json:"image,omitempty"`
	Link *map[string]any `json:"link,omitempty"`
	Name *string `json:"name,omitempty"`
	Number *int `json:"number,omitempty"`
	Rating *map[string]any `json:"rating,omitempty"`
	Runtime *int `json:"runtime,omitempty"`
	Season *int `json:"season,omitempty"`
	Show *map[string]any `json:"show,omitempty"`
	Summary *string `json:"summary,omitempty"`
	Type *string `json:"type,omitempty"`
	Url *string `json:"url,omitempty"`
}

// Search is the typed data model for the search entity.
type Search struct {
}

// SearchLoadMatch mirrors the search fields as an all-optional match
// filter (Go analog of Partial<Search>).
type SearchLoadMatch struct {
}

// Season is the typed data model for the season entity.
type Season struct {
	EndDate *string `json:"end_date,omitempty"`
	EpisodeOrder *int `json:"episode_order,omitempty"`
	Id *int `json:"id,omitempty"`
	Image *map[string]any `json:"image,omitempty"`
	Link *map[string]any `json:"link,omitempty"`
	Name *string `json:"name,omitempty"`
	Network *map[string]any `json:"network,omitempty"`
	Number *int `json:"number,omitempty"`
	PremiereDate *string `json:"premiere_date,omitempty"`
	Summary *string `json:"summary,omitempty"`
	Url *string `json:"url,omitempty"`
	WebChannel *map[string]any `json:"web_channel,omitempty"`
}

// SeasonListMatch is the typed request payload for Season.ListTyped.
type SeasonListMatch struct {
	ShowId int `json:"show_id"`
}

// Show is the typed data model for the show entity.
type Show struct {
	AverageRuntime *int `json:"average_runtime,omitempty"`
	DvdCountry *map[string]any `json:"dvd_country,omitempty"`
	Ended *string `json:"ended,omitempty"`
	External *map[string]any `json:"external,omitempty"`
	Genre *[]any `json:"genre,omitempty"`
	Id *int `json:"id,omitempty"`
	Image *map[string]any `json:"image,omitempty"`
	Language *string `json:"language,omitempty"`
	Link *map[string]any `json:"link,omitempty"`
	Name *string `json:"name,omitempty"`
	Network *map[string]any `json:"network,omitempty"`
	OfficialSite *string `json:"official_site,omitempty"`
	Premiered *string `json:"premiered,omitempty"`
	Rating *map[string]any `json:"rating,omitempty"`
	Runtime *int `json:"runtime,omitempty"`
	Schedule *map[string]any `json:"schedule,omitempty"`
	Score *float64 `json:"score,omitempty"`
	Show *map[string]any `json:"show,omitempty"`
	Status *string `json:"status,omitempty"`
	Summary *string `json:"summary,omitempty"`
	Type *string `json:"type,omitempty"`
	Updated *int `json:"updated,omitempty"`
	Url *string `json:"url,omitempty"`
	WebChannel *map[string]any `json:"web_channel,omitempty"`
	Weight *int `json:"weight,omitempty"`
}

// ShowLoadMatch is the typed request payload for Show.LoadTyped.
type ShowLoadMatch struct {
	Id int `json:"id"`
}

// ShowListMatch is the typed request payload for Show.ListTyped.
type ShowListMatch struct {
	AlternatelistId int `json:"alternatelist_id"`
}

// Update is the typed data model for the update entity.
type Update struct {
}

// UpdateLoadMatch mirrors the update fields as an all-optional match
// filter (Go analog of Partial<Update>).
type UpdateLoadMatch struct {
}

// asMap turns a typed request/data struct into the map[string]any the
// runtime op pipeline consumes, honouring the json tags above.
func asMap(v any) map[string]any {
	out := map[string]any{}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedFrom decodes a runtime value (a map[string]any produced by the op
// pipeline) into a typed model T via a JSON round-trip. On any error it
// returns the zero value of T; the op's own (value, error) tuple carries the
// real error.
func typedFrom[T any](v any) T {
	var out T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}

// typedSliceFrom decodes a runtime list value ([]any of maps) into a typed
// slice []T via a JSON round-trip, for list ops.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
