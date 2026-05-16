<?php
declare(strict_types=1);

// Tvmaze SDK utility: make_context

require_once __DIR__ . '/../core/Context.php';

class TvmazeMakeContext
{
    public static function call(array $ctxmap, ?TvmazeContext $basectx): TvmazeContext
    {
        return new TvmazeContext($ctxmap, $basectx);
    }
}
