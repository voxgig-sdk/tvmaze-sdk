<?php
declare(strict_types=1);

// Tvmaze SDK utility: feature_add

class TvmazeFeatureAdd
{
    public static function call(TvmazeContext $ctx, mixed $f): void
    {
        $ctx->client->features[] = $f;
    }
}
