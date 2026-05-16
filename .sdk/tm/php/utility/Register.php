<?php
declare(strict_types=1);

// Tvmaze SDK utility registration

require_once __DIR__ . '/../core/UtilityType.php';
require_once __DIR__ . '/Clean.php';
require_once __DIR__ . '/Done.php';
require_once __DIR__ . '/MakeError.php';
require_once __DIR__ . '/FeatureAdd.php';
require_once __DIR__ . '/FeatureHook.php';
require_once __DIR__ . '/FeatureInit.php';
require_once __DIR__ . '/Fetcher.php';
require_once __DIR__ . '/MakeFetchDef.php';
require_once __DIR__ . '/MakeContext.php';
require_once __DIR__ . '/MakeOptions.php';
require_once __DIR__ . '/MakeRequest.php';
require_once __DIR__ . '/MakeResponse.php';
require_once __DIR__ . '/MakeResult.php';
require_once __DIR__ . '/MakePoint.php';
require_once __DIR__ . '/MakeSpec.php';
require_once __DIR__ . '/MakeUrl.php';
require_once __DIR__ . '/Param.php';
require_once __DIR__ . '/PrepareAuth.php';
require_once __DIR__ . '/PrepareBody.php';
require_once __DIR__ . '/PrepareHeaders.php';
require_once __DIR__ . '/PrepareMethod.php';
require_once __DIR__ . '/PrepareParams.php';
require_once __DIR__ . '/PreparePath.php';
require_once __DIR__ . '/PrepareQuery.php';
require_once __DIR__ . '/ResultBasic.php';
require_once __DIR__ . '/ResultBody.php';
require_once __DIR__ . '/ResultHeaders.php';
require_once __DIR__ . '/TransformRequest.php';
require_once __DIR__ . '/TransformResponse.php';

TvmazeUtility::setRegistrar(function (TvmazeUtility $u): void {
    $u->clean = [TvmazeClean::class, 'call'];
    $u->done = [TvmazeDone::class, 'call'];
    $u->make_error = [TvmazeMakeError::class, 'call'];
    $u->feature_add = [TvmazeFeatureAdd::class, 'call'];
    $u->feature_hook = [TvmazeFeatureHook::class, 'call'];
    $u->feature_init = [TvmazeFeatureInit::class, 'call'];
    $u->fetcher = [TvmazeFetcher::class, 'call'];
    $u->make_fetch_def = [TvmazeMakeFetchDef::class, 'call'];
    $u->make_context = [TvmazeMakeContext::class, 'call'];
    $u->make_options = [TvmazeMakeOptions::class, 'call'];
    $u->make_request = [TvmazeMakeRequest::class, 'call'];
    $u->make_response = [TvmazeMakeResponse::class, 'call'];
    $u->make_result = [TvmazeMakeResult::class, 'call'];
    $u->make_point = [TvmazeMakePoint::class, 'call'];
    $u->make_spec = [TvmazeMakeSpec::class, 'call'];
    $u->make_url = [TvmazeMakeUrl::class, 'call'];
    $u->param = [TvmazeParam::class, 'call'];
    $u->prepare_auth = [TvmazePrepareAuth::class, 'call'];
    $u->prepare_body = [TvmazePrepareBody::class, 'call'];
    $u->prepare_headers = [TvmazePrepareHeaders::class, 'call'];
    $u->prepare_method = [TvmazePrepareMethod::class, 'call'];
    $u->prepare_params = [TvmazePrepareParams::class, 'call'];
    $u->prepare_path = [TvmazePreparePath::class, 'call'];
    $u->prepare_query = [TvmazePrepareQuery::class, 'call'];
    $u->result_basic = [TvmazeResultBasic::class, 'call'];
    $u->result_body = [TvmazeResultBody::class, 'call'];
    $u->result_headers = [TvmazeResultHeaders::class, 'call'];
    $u->transform_request = [TvmazeTransformRequest::class, 'call'];
    $u->transform_response = [TvmazeTransformResponse::class, 'call'];
});
