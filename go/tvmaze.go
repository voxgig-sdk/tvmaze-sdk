package voxgigtvmazesdk

import (
	"github.com/voxgig-sdk/tvmaze-sdk/core"
	"github.com/voxgig-sdk/tvmaze-sdk/entity"
	"github.com/voxgig-sdk/tvmaze-sdk/feature"
	_ "github.com/voxgig-sdk/tvmaze-sdk/utility"
)

// Type aliases preserve external API.
type TvmazeSDK = core.TvmazeSDK
type Context = core.Context
type Utility = core.Utility
type Feature = core.Feature
type Entity = core.Entity
type TvmazeEntity = core.TvmazeEntity
type FetcherFunc = core.FetcherFunc
type Spec = core.Spec
type Result = core.Result
type Response = core.Response
type Operation = core.Operation
type Control = core.Control
type TvmazeError = core.TvmazeError

// BaseFeature from feature package.
type BaseFeature = feature.BaseFeature

func init() {
	core.NewBaseFeatureFunc = func() core.Feature {
		return feature.NewBaseFeature()
	}
	core.NewTestFeatureFunc = func() core.Feature {
		return feature.NewTestFeature()
	}
	core.NewAkaEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewAkaEntity(client, entopts)
	}
	core.NewAlternateListEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewAlternateListEntity(client, entopts)
	}
	core.NewCastEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewCastEntity(client, entopts)
	}
	core.NewCastCreditEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewCastCreditEntity(client, entopts)
	}
	core.NewCastMemberEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewCastMemberEntity(client, entopts)
	}
	core.NewCrewEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewCrewEntity(client, entopts)
	}
	core.NewCrewCreditEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewCrewCreditEntity(client, entopts)
	}
	core.NewCrewMemberEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewCrewMemberEntity(client, entopts)
	}
	core.NewEpisodeEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewEpisodeEntity(client, entopts)
	}
	core.NewGuestCastCreditEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewGuestCastCreditEntity(client, entopts)
	}
	core.NewImageEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewImageEntity(client, entopts)
	}
	core.NewPersonEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewPersonEntity(client, entopts)
	}
	core.NewScheduleEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewScheduleEntity(client, entopts)
	}
	core.NewScheduledEpisodeEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewScheduledEpisodeEntity(client, entopts)
	}
	core.NewSearchEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewSearchEntity(client, entopts)
	}
	core.NewSeasonEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewSeasonEntity(client, entopts)
	}
	core.NewShowEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewShowEntity(client, entopts)
	}
	core.NewUpdateEntityFunc = func(client *core.TvmazeSDK, entopts map[string]any) core.TvmazeEntity {
		return entity.NewUpdateEntity(client, entopts)
	}
}

// Constructor re-exports.
var NewTvmazeSDK = core.NewTvmazeSDK
var TestSDK = core.TestSDK
var NewContext = core.NewContext
var NewSpec = core.NewSpec
var NewResult = core.NewResult
var NewResponse = core.NewResponse
var NewOperation = core.NewOperation
var MakeConfig = core.MakeConfig
var NewBaseFeature = feature.NewBaseFeature
var NewTestFeature = feature.NewTestFeature
