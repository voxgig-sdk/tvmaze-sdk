# Tvmaze SDK utility registration
require_relative '../core/utility_type'
require_relative 'clean'
require_relative 'done'
require_relative 'make_error'
require_relative 'feature_add'
require_relative 'feature_hook'
require_relative 'feature_init'
require_relative 'fetcher'
require_relative 'make_fetch_def'
require_relative 'make_context'
require_relative 'make_options'
require_relative 'make_request'
require_relative 'make_response'
require_relative 'make_result'
require_relative 'make_point'
require_relative 'make_spec'
require_relative 'make_url'
require_relative 'param'
require_relative 'prepare_auth'
require_relative 'prepare_body'
require_relative 'prepare_headers'
require_relative 'prepare_method'
require_relative 'prepare_params'
require_relative 'prepare_path'
require_relative 'prepare_query'
require_relative 'result_basic'
require_relative 'result_body'
require_relative 'result_headers'
require_relative 'transform_request'
require_relative 'transform_response'

TvmazeUtility.registrar = ->(u) {
  u.clean = TvmazeUtilities::Clean
  u.done = TvmazeUtilities::Done
  u.make_error = TvmazeUtilities::MakeError
  u.feature_add = TvmazeUtilities::FeatureAdd
  u.feature_hook = TvmazeUtilities::FeatureHook
  u.feature_init = TvmazeUtilities::FeatureInit
  u.fetcher = TvmazeUtilities::Fetcher
  u.make_fetch_def = TvmazeUtilities::MakeFetchDef
  u.make_context = TvmazeUtilities::MakeContext
  u.make_options = TvmazeUtilities::MakeOptions
  u.make_request = TvmazeUtilities::MakeRequest
  u.make_response = TvmazeUtilities::MakeResponse
  u.make_result = TvmazeUtilities::MakeResult
  u.make_point = TvmazeUtilities::MakePoint
  u.make_spec = TvmazeUtilities::MakeSpec
  u.make_url = TvmazeUtilities::MakeUrl
  u.param = TvmazeUtilities::Param
  u.prepare_auth = TvmazeUtilities::PrepareAuth
  u.prepare_body = TvmazeUtilities::PrepareBody
  u.prepare_headers = TvmazeUtilities::PrepareHeaders
  u.prepare_method = TvmazeUtilities::PrepareMethod
  u.prepare_params = TvmazeUtilities::PrepareParams
  u.prepare_path = TvmazeUtilities::PreparePath
  u.prepare_query = TvmazeUtilities::PrepareQuery
  u.result_basic = TvmazeUtilities::ResultBasic
  u.result_body = TvmazeUtilities::ResultBody
  u.result_headers = TvmazeUtilities::ResultHeaders
  u.transform_request = TvmazeUtilities::TransformRequest
  u.transform_response = TvmazeUtilities::TransformResponse
}
