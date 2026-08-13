// Typed models for the Tvmaze SDK.
//
// GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
// params (op.<name>.points[].args.params[]). Field/param types come from the
// canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
// @voxgig/apidef VALID_CANON). Do not edit by hand.
package entity

import (
	"encoding/json"

	"github.com/voxgig-sdk/tvmaze-sdk/go/core"
)

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
	Links *map[string]any `json:"links,omitempty"`
	Name *string `json:"name,omitempty"`
	Self *map[string]any `json:"self,omitempty"`
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
	Links *map[string]any `json:"links,omitempty"`
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
	Links *map[string]any `json:"links,omitempty"`
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
	Links *map[string]any `json:"links,omitempty"`
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
	ShowId *int `json:"show_id,omitempty"`
	Id *int `json:"id,omitempty"`
}

// EpisodeListMatch is the typed request payload for Episode.ListTyped.
type EpisodeListMatch struct {
	ShowId *int `json:"show_id,omitempty"`
	SeasonId *int `json:"season_id,omitempty"`
}

// GuestCastCredit is the typed data model for the guest_cast_credit entity.
type GuestCastCredit struct {
	Links *map[string]any `json:"links,omitempty"`
}

// GuestCastCreditListMatch is the typed request payload for GuestCastCredit.ListTyped.
type GuestCastCreditListMatch struct {
	PersonId int `json:"person_id"`
}

// Image is the typed data model for the image entity.
type Image struct {
	Id *int `json:"id,omitempty"`
	Main *bool `json:"main,omitempty"`
	Resolutions *map[string]any `json:"resolutions,omitempty"`
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
	Links *map[string]any `json:"links,omitempty"`
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

// PersonListMatch is the typed request payload for Person.ListTyped.
type PersonListMatch struct {
	Birthday *string `json:"birthday,omitempty"`
	Country *map[string]any `json:"country,omitempty"`
	Deathday *string `json:"deathday,omitempty"`
	Gender *string `json:"gender,omitempty"`
	Id *int `json:"id,omitempty"`
	Image *map[string]any `json:"image,omitempty"`
	Links *map[string]any `json:"links,omitempty"`
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
	Links *map[string]any `json:"links,omitempty"`
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

// ScheduleListMatch is the typed request payload for Schedule.ListTyped.
type ScheduleListMatch struct {
	Airdate *string `json:"airdate,omitempty"`
	Airstamp *string `json:"airstamp,omitempty"`
	Airtime *string `json:"airtime,omitempty"`
	Id *int `json:"id,omitempty"`
	Image *map[string]any `json:"image,omitempty"`
	Links *map[string]any `json:"links,omitempty"`
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
	Links *map[string]any `json:"links,omitempty"`
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

// ScheduledEpisodeListMatch is the typed request payload for ScheduledEpisode.ListTyped.
type ScheduledEpisodeListMatch struct {
	Airdate *string `json:"airdate,omitempty"`
	Airstamp *string `json:"airstamp,omitempty"`
	Airtime *string `json:"airtime,omitempty"`
	Id *int `json:"id,omitempty"`
	Image *map[string]any `json:"image,omitempty"`
	Links *map[string]any `json:"links,omitempty"`
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

// SearchLoadMatch is the typed request payload for Search.LoadTyped.
type SearchLoadMatch struct {
}

// Season is the typed data model for the season entity.
type Season struct {
	EndDate *string `json:"endDate,omitempty"`
	EpisodeOrder *int `json:"episodeOrder,omitempty"`
	Id *int `json:"id,omitempty"`
	Image *map[string]any `json:"image,omitempty"`
	Links *map[string]any `json:"links,omitempty"`
	Name *string `json:"name,omitempty"`
	Network *map[string]any `json:"network,omitempty"`
	Number *int `json:"number,omitempty"`
	PremiereDate *string `json:"premiereDate,omitempty"`
	Summary *string `json:"summary,omitempty"`
	Url *string `json:"url,omitempty"`
	WebChannel *map[string]any `json:"webChannel,omitempty"`
}

// SeasonListMatch is the typed request payload for Season.ListTyped.
type SeasonListMatch struct {
	ShowId int `json:"show_id"`
}

// Show is the typed data model for the show entity.
type Show struct {
	AverageRuntime *int `json:"averageRuntime,omitempty"`
	DvdCountry *map[string]any `json:"dvdCountry,omitempty"`
	Ended *string `json:"ended,omitempty"`
	Externals *map[string]any `json:"externals,omitempty"`
	Genres *[]any `json:"genres,omitempty"`
	Id *int `json:"id,omitempty"`
	Image *map[string]any `json:"image,omitempty"`
	Language *string `json:"language,omitempty"`
	Links *map[string]any `json:"links,omitempty"`
	Name *string `json:"name,omitempty"`
	Network *map[string]any `json:"network,omitempty"`
	OfficialSite *string `json:"officialSite,omitempty"`
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
	WebChannel *map[string]any `json:"webChannel,omitempty"`
	Weight *int `json:"weight,omitempty"`
}

// ShowLoadMatch is the typed request payload for Show.LoadTyped.
type ShowLoadMatch struct {
	Id int `json:"id"`
}

// ShowListMatch is the typed request payload for Show.ListTyped.
type ShowListMatch struct {
	AlternatelistId *int `json:"alternatelist_id,omitempty"`
}

// Update is the typed data model for the update entity.
type Update struct {
}

// UpdateLoadMatch is the typed request payload for Update.LoadTyped.
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

// entityData unwraps an entity to its data map.
//
// Operations resolve to the ENTITY, not the raw data (see AGENTS.md), and an
// entity's fields are UNEXPORTED — marshalling one directly yields `{}`, so
// every typed accessor would silently hand back a zero-valued struct. The
// typed boundary therefore takes the data hop first.
func entityData(v any) any {
	if ent, ok := v.(core.Entity); ok {
		return ent.Data()
	}
	return v
}

// typedFrom decodes a runtime value (an entity, or the map[string]any the op
// pipeline produced) into a typed model T via a JSON round-trip. On any error
// it returns the zero value of T; the op's own (value, error) tuple carries
// the real error.
func typedFrom[T any](v any) T {
	var out T
	v = entityData(v)
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

// typedSliceFrom decodes a runtime list value into a typed slice []T via a
// JSON round-trip, for list ops. `list` resolves to a slice of ENTITY
// instances, so each element takes the data hop.
func typedSliceFrom[T any](v any) []T {
	var out []T
	if v == nil {
		return out
	}
	if list, ok := v.([]any); ok {
		unwrapped := make([]any, 0, len(list))
		for _, item := range list {
			unwrapped = append(unwrapped, entityData(item))
		}
		v = unwrapped
	}
	b, err := json.Marshal(v)
	if err != nil {
		return out
	}
	_ = json.Unmarshal(b, &out)
	return out
}
