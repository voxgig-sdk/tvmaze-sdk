<?php
declare(strict_types=1);

// Tvmaze SDK base feature

class TvmazeBaseFeature
{
    public string $version;
    public string $name;
    public bool $active;

    public function __construct()
    {
        $this->version = '0.0.1';
        $this->name = 'base';
        $this->active = true;
    }

    public function get_version(): string { return $this->version; }
    public function get_name(): string { return $this->name; }
    public function get_active(): bool { return $this->active; }

    public function init(TvmazeContext $ctx, array $options): void {}
    public function PostConstruct(TvmazeContext $ctx): void {}
    public function PostConstructEntity(TvmazeContext $ctx): void {}
    public function SetData(TvmazeContext $ctx): void {}
    public function GetData(TvmazeContext $ctx): void {}
    public function GetMatch(TvmazeContext $ctx): void {}
    public function SetMatch(TvmazeContext $ctx): void {}
    public function PrePoint(TvmazeContext $ctx): void {}
    public function PreSpec(TvmazeContext $ctx): void {}
    public function PreRequest(TvmazeContext $ctx): void {}
    public function PreResponse(TvmazeContext $ctx): void {}
    public function PreResult(TvmazeContext $ctx): void {}
    public function PreDone(TvmazeContext $ctx): void {}
    public function PreUnexpected(TvmazeContext $ctx): void {}
}
