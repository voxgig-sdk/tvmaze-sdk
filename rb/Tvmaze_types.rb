# frozen_string_literal: true

# Typed models for the Tvmaze SDK.
#
# GENERATED from the API model: main.kit.entity.<e>.fields[] and per-op
# params (op.<name>.points[].args.params[]). Member types come from the
# canonical type sentinels via @voxgig/sdkgen canonToType (source of truth:
# @voxgig/apidef VALID_CANON). Ruby types are unenforced; these YARD
# annotations document the shapes. Do not edit by hand.

# Aka entity data model.
#
# @!attribute [rw] country
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
Aka = Struct.new(
  :country,
  :name,
  keyword_init: true
)

# Request payload for Aka#list.
#
# @!attribute [rw] show_id
#   @return [Integer]
AkaListMatch = Struct.new(
  :show_id,
  keyword_init: true
)

# AlternateList entity data model.
#
# @!attribute [rw] id
#   @return [Integer, nil]
#
# @!attribute [rw] link
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
AlternateList = Struct.new(
  :id,
  :link,
  :name,
  :url,
  keyword_init: true
)

# Request payload for AlternateList#load.
#
# @!attribute [rw] id
#   @return [Integer]
AlternateListLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for AlternateList#list.
#
# @!attribute [rw] show_id
#   @return [Integer]
AlternateListListMatch = Struct.new(
  :show_id,
  keyword_init: true
)

# Cast entity data model.
#
# @!attribute [rw] character
#   @return [Hash, nil]
#
# @!attribute [rw] person
#   @return [Hash, nil]
#
# @!attribute [rw] self
#   @return [Boolean, nil]
#
# @!attribute [rw] voice
#   @return [Boolean, nil]
Cast = Struct.new(
  :character,
  :person,
  :self,
  :voice,
  keyword_init: true
)

# Request payload for Cast#list.
#
# @!attribute [rw] show_id
#   @return [Integer]
CastListMatch = Struct.new(
  :show_id,
  keyword_init: true
)

# CastCredit entity data model.
#
# @!attribute [rw] link
#   @return [Hash, nil]
CastCredit = Struct.new(
  :link,
  keyword_init: true
)

# Request payload for CastCredit#list.
#
# @!attribute [rw] person_id
#   @return [Integer]
CastCreditListMatch = Struct.new(
  :person_id,
  keyword_init: true
)

# CastMember entity data model.
#
# @!attribute [rw] character
#   @return [Hash, nil]
#
# @!attribute [rw] person
#   @return [Hash, nil]
#
# @!attribute [rw] self
#   @return [Boolean, nil]
#
# @!attribute [rw] voice
#   @return [Boolean, nil]
CastMember = Struct.new(
  :character,
  :person,
  :self,
  :voice,
  keyword_init: true
)

# Request payload for CastMember#list.
#
# @!attribute [rw] episode_id
#   @return [Integer]
CastMemberListMatch = Struct.new(
  :episode_id,
  keyword_init: true
)

# Crew entity data model.
#
# @!attribute [rw] person
#   @return [Hash, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
Crew = Struct.new(
  :person,
  :type,
  keyword_init: true
)

# Request payload for Crew#list.
#
# @!attribute [rw] show_id
#   @return [Integer]
CrewListMatch = Struct.new(
  :show_id,
  keyword_init: true
)

# CrewCredit entity data model.
#
# @!attribute [rw] link
#   @return [Hash, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
CrewCredit = Struct.new(
  :link,
  :type,
  keyword_init: true
)

# Request payload for CrewCredit#list.
#
# @!attribute [rw] person_id
#   @return [Integer]
CrewCreditListMatch = Struct.new(
  :person_id,
  keyword_init: true
)

# CrewMember entity data model.
#
# @!attribute [rw] person
#   @return [Hash, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
CrewMember = Struct.new(
  :person,
  :type,
  keyword_init: true
)

# Request payload for CrewMember#list.
#
# @!attribute [rw] episode_id
#   @return [Integer]
CrewMemberListMatch = Struct.new(
  :episode_id,
  keyword_init: true
)

# Episode entity data model.
#
# @!attribute [rw] airdate
#   @return [String, nil]
#
# @!attribute [rw] airstamp
#   @return [String, nil]
#
# @!attribute [rw] airtime
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [Integer, nil]
#
# @!attribute [rw] image
#   @return [Hash, nil]
#
# @!attribute [rw] link
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] number
#   @return [Integer, nil]
#
# @!attribute [rw] rating
#   @return [Hash, nil]
#
# @!attribute [rw] runtime
#   @return [Integer, nil]
#
# @!attribute [rw] season
#   @return [Integer, nil]
#
# @!attribute [rw] summary
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
Episode = Struct.new(
  :airdate,
  :airstamp,
  :airtime,
  :id,
  :image,
  :link,
  :name,
  :number,
  :rating,
  :runtime,
  :season,
  :summary,
  :type,
  :url,
  keyword_init: true
)

# Request payload for Episode#load.
#
# @!attribute [rw] show_id
#   @return [Integer, nil]
#
# @!attribute [rw] id
#   @return [Integer, nil]
EpisodeLoadMatch = Struct.new(
  :show_id,
  :id,
  keyword_init: true
)

# Request payload for Episode#list.
#
# @!attribute [rw] show_id
#   @return [Integer, nil]
#
# @!attribute [rw] season_id
#   @return [Integer, nil]
EpisodeListMatch = Struct.new(
  :show_id,
  :season_id,
  keyword_init: true
)

# GuestCastCredit entity data model.
#
# @!attribute [rw] link
#   @return [Hash, nil]
GuestCastCredit = Struct.new(
  :link,
  keyword_init: true
)

# Request payload for GuestCastCredit#list.
#
# @!attribute [rw] person_id
#   @return [Integer]
GuestCastCreditListMatch = Struct.new(
  :person_id,
  keyword_init: true
)

# Image entity data model.
#
# @!attribute [rw] id
#   @return [Integer, nil]
#
# @!attribute [rw] main
#   @return [Boolean, nil]
#
# @!attribute [rw] resolution
#   @return [Hash, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
Image = Struct.new(
  :id,
  :main,
  :resolution,
  :type,
  keyword_init: true
)

# Request payload for Image#list.
#
# @!attribute [rw] show_id
#   @return [Integer]
ImageListMatch = Struct.new(
  :show_id,
  keyword_init: true
)

# Person entity data model.
#
# @!attribute [rw] birthday
#   @return [String, nil]
#
# @!attribute [rw] country
#   @return [Hash, nil]
#
# @!attribute [rw] deathday
#   @return [String, nil]
#
# @!attribute [rw] gender
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [Integer, nil]
#
# @!attribute [rw] image
#   @return [Hash, nil]
#
# @!attribute [rw] link
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] person
#   @return [Hash, nil]
#
# @!attribute [rw] score
#   @return [Float, nil]
#
# @!attribute [rw] updated
#   @return [Integer, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
Person = Struct.new(
  :birthday,
  :country,
  :deathday,
  :gender,
  :id,
  :image,
  :link,
  :name,
  :person,
  :score,
  :updated,
  :url,
  keyword_init: true
)

# Request payload for Person#load.
#
# @!attribute [rw] id
#   @return [Integer]
PersonLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Person#list.
#
# @!attribute [rw] birthday
#   @return [String, nil]
#
# @!attribute [rw] country
#   @return [Hash, nil]
#
# @!attribute [rw] deathday
#   @return [String, nil]
#
# @!attribute [rw] gender
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [Integer, nil]
#
# @!attribute [rw] image
#   @return [Hash, nil]
#
# @!attribute [rw] link
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] person
#   @return [Hash, nil]
#
# @!attribute [rw] score
#   @return [Float, nil]
#
# @!attribute [rw] updated
#   @return [Integer, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
PersonListMatch = Struct.new(
  :birthday,
  :country,
  :deathday,
  :gender,
  :id,
  :image,
  :link,
  :name,
  :person,
  :score,
  :updated,
  :url,
  keyword_init: true
)

# Schedule entity data model.
#
# @!attribute [rw] airdate
#   @return [String, nil]
#
# @!attribute [rw] airstamp
#   @return [String, nil]
#
# @!attribute [rw] airtime
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [Integer, nil]
#
# @!attribute [rw] image
#   @return [Hash, nil]
#
# @!attribute [rw] link
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] number
#   @return [Integer, nil]
#
# @!attribute [rw] rating
#   @return [Hash, nil]
#
# @!attribute [rw] runtime
#   @return [Integer, nil]
#
# @!attribute [rw] season
#   @return [Integer, nil]
#
# @!attribute [rw] show
#   @return [Hash, nil]
#
# @!attribute [rw] summary
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
Schedule = Struct.new(
  :airdate,
  :airstamp,
  :airtime,
  :id,
  :image,
  :link,
  :name,
  :number,
  :rating,
  :runtime,
  :season,
  :show,
  :summary,
  :type,
  :url,
  keyword_init: true
)

# Request payload for Schedule#list.
#
# @!attribute [rw] airdate
#   @return [String, nil]
#
# @!attribute [rw] airstamp
#   @return [String, nil]
#
# @!attribute [rw] airtime
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [Integer, nil]
#
# @!attribute [rw] image
#   @return [Hash, nil]
#
# @!attribute [rw] link
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] number
#   @return [Integer, nil]
#
# @!attribute [rw] rating
#   @return [Hash, nil]
#
# @!attribute [rw] runtime
#   @return [Integer, nil]
#
# @!attribute [rw] season
#   @return [Integer, nil]
#
# @!attribute [rw] show
#   @return [Hash, nil]
#
# @!attribute [rw] summary
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
ScheduleListMatch = Struct.new(
  :airdate,
  :airstamp,
  :airtime,
  :id,
  :image,
  :link,
  :name,
  :number,
  :rating,
  :runtime,
  :season,
  :show,
  :summary,
  :type,
  :url,
  keyword_init: true
)

# ScheduledEpisode entity data model.
#
# @!attribute [rw] airdate
#   @return [String, nil]
#
# @!attribute [rw] airstamp
#   @return [String, nil]
#
# @!attribute [rw] airtime
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [Integer, nil]
#
# @!attribute [rw] image
#   @return [Hash, nil]
#
# @!attribute [rw] link
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] number
#   @return [Integer, nil]
#
# @!attribute [rw] rating
#   @return [Hash, nil]
#
# @!attribute [rw] runtime
#   @return [Integer, nil]
#
# @!attribute [rw] season
#   @return [Integer, nil]
#
# @!attribute [rw] show
#   @return [Hash, nil]
#
# @!attribute [rw] summary
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
ScheduledEpisode = Struct.new(
  :airdate,
  :airstamp,
  :airtime,
  :id,
  :image,
  :link,
  :name,
  :number,
  :rating,
  :runtime,
  :season,
  :show,
  :summary,
  :type,
  :url,
  keyword_init: true
)

# Request payload for ScheduledEpisode#list.
#
# @!attribute [rw] airdate
#   @return [String, nil]
#
# @!attribute [rw] airstamp
#   @return [String, nil]
#
# @!attribute [rw] airtime
#   @return [String, nil]
#
# @!attribute [rw] id
#   @return [Integer, nil]
#
# @!attribute [rw] image
#   @return [Hash, nil]
#
# @!attribute [rw] link
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] number
#   @return [Integer, nil]
#
# @!attribute [rw] rating
#   @return [Hash, nil]
#
# @!attribute [rw] runtime
#   @return [Integer, nil]
#
# @!attribute [rw] season
#   @return [Integer, nil]
#
# @!attribute [rw] show
#   @return [Hash, nil]
#
# @!attribute [rw] summary
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
ScheduledEpisodeListMatch = Struct.new(
  :airdate,
  :airstamp,
  :airtime,
  :id,
  :image,
  :link,
  :name,
  :number,
  :rating,
  :runtime,
  :season,
  :show,
  :summary,
  :type,
  :url,
  keyword_init: true
)

# Search entity data model.
class Search
end

# Request payload for Search#load.
class SearchLoadMatch
end

# Season entity data model.
#
# @!attribute [rw] end_date
#   @return [String, nil]
#
# @!attribute [rw] episode_order
#   @return [Integer, nil]
#
# @!attribute [rw] id
#   @return [Integer, nil]
#
# @!attribute [rw] image
#   @return [Hash, nil]
#
# @!attribute [rw] link
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] network
#   @return [Hash, nil]
#
# @!attribute [rw] number
#   @return [Integer, nil]
#
# @!attribute [rw] premiere_date
#   @return [String, nil]
#
# @!attribute [rw] summary
#   @return [String, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
#
# @!attribute [rw] web_channel
#   @return [Hash, nil]
Season = Struct.new(
  :end_date,
  :episode_order,
  :id,
  :image,
  :link,
  :name,
  :network,
  :number,
  :premiere_date,
  :summary,
  :url,
  :web_channel,
  keyword_init: true
)

# Request payload for Season#list.
#
# @!attribute [rw] show_id
#   @return [Integer]
SeasonListMatch = Struct.new(
  :show_id,
  keyword_init: true
)

# Show entity data model.
#
# @!attribute [rw] average_runtime
#   @return [Integer, nil]
#
# @!attribute [rw] dvd_country
#   @return [Hash, nil]
#
# @!attribute [rw] ended
#   @return [String, nil]
#
# @!attribute [rw] external
#   @return [Hash, nil]
#
# @!attribute [rw] genre
#   @return [Array, nil]
#
# @!attribute [rw] id
#   @return [Integer, nil]
#
# @!attribute [rw] image
#   @return [Hash, nil]
#
# @!attribute [rw] language
#   @return [String, nil]
#
# @!attribute [rw] link
#   @return [Hash, nil]
#
# @!attribute [rw] name
#   @return [String, nil]
#
# @!attribute [rw] network
#   @return [Hash, nil]
#
# @!attribute [rw] official_site
#   @return [String, nil]
#
# @!attribute [rw] premiered
#   @return [String, nil]
#
# @!attribute [rw] rating
#   @return [Hash, nil]
#
# @!attribute [rw] runtime
#   @return [Integer, nil]
#
# @!attribute [rw] schedule
#   @return [Hash, nil]
#
# @!attribute [rw] score
#   @return [Float, nil]
#
# @!attribute [rw] show
#   @return [Hash, nil]
#
# @!attribute [rw] status
#   @return [String, nil]
#
# @!attribute [rw] summary
#   @return [String, nil]
#
# @!attribute [rw] type
#   @return [String, nil]
#
# @!attribute [rw] updated
#   @return [Integer, nil]
#
# @!attribute [rw] url
#   @return [String, nil]
#
# @!attribute [rw] web_channel
#   @return [Hash, nil]
#
# @!attribute [rw] weight
#   @return [Integer, nil]
Show = Struct.new(
  :average_runtime,
  :dvd_country,
  :ended,
  :external,
  :genre,
  :id,
  :image,
  :language,
  :link,
  :name,
  :network,
  :official_site,
  :premiered,
  :rating,
  :runtime,
  :schedule,
  :score,
  :show,
  :status,
  :summary,
  :type,
  :updated,
  :url,
  :web_channel,
  :weight,
  keyword_init: true
)

# Request payload for Show#load.
#
# @!attribute [rw] id
#   @return [Integer]
ShowLoadMatch = Struct.new(
  :id,
  keyword_init: true
)

# Request payload for Show#list.
#
# @!attribute [rw] alternatelist_id
#   @return [Integer, nil]
ShowListMatch = Struct.new(
  :alternatelist_id,
  keyword_init: true
)

# Update entity data model.
class Update
end

# Request payload for Update#load.
class UpdateLoadMatch
end

