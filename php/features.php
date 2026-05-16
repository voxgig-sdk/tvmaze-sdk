<?php
declare(strict_types=1);

// Tvmaze SDK feature factory

require_once __DIR__ . '/feature/BaseFeature.php';
require_once __DIR__ . '/feature/TestFeature.php';


class TvmazeFeatures
{
    public static function make_feature(string $name)
    {
        switch ($name) {
            case "base":
                return new TvmazeBaseFeature();
            case "test":
                return new TvmazeTestFeature();
            default:
                return new TvmazeBaseFeature();
        }
    }
}
