<?php
declare(strict_types=1);

// Tvmaze SDK utility: result_headers

class TvmazeResultHeaders
{
    public static function call(TvmazeContext $ctx): ?TvmazeResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result) {
            if ($response && is_array($response->headers)) {
                $result->headers = $response->headers;
            } else {
                $result->headers = [];
            }
        }
        return $result;
    }
}
