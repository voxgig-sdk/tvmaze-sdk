package core

var UtilityRegistrar func(u *Utility)

var NewBaseFeatureFunc func() Feature

var NewTestFeatureFunc func() Feature

var NewAkaEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewAlternateListEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewCastEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewCastCreditEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewCastMemberEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewCrewEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewCrewCreditEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewCrewMemberEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewEpisodeEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewGuestCastCreditEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewImageEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewPersonEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewScheduleEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewScheduledEpisodeEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewSearchEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewSeasonEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewShowEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

var NewUpdateEntityFunc func(client *TvmazeSDK, entopts map[string]any) TvmazeEntity

