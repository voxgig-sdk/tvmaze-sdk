<?php
declare(strict_types=1);

// Tvmaze SDK utility: result_body

class TvmazeResultBody
{
    public static function call(TvmazeContext $ctx): ?TvmazeResult
    {
        $response = $ctx->response;
        $result = $ctx->result;
        if ($result && $response && $response->json_func && $response->body) {
            $result->body = ($response->json_func)();
        }
        return $result;
    }
}
