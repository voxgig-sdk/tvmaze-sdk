<?php
declare(strict_types=1);

// Tvmaze SDK utility: prepare_body

class TvmazePrepareBody
{
    public static function call(TvmazeContext $ctx): mixed
    {
        if ($ctx->op->input === 'data') {
            return ($ctx->utility->transform_request)($ctx);
        }
        return null;
    }
}
