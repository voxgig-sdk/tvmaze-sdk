<?php
declare(strict_types=1);

// Tvmaze SDK exists test

require_once __DIR__ . '/../tvmaze_sdk.php';

use PHPUnit\Framework\TestCase;

class ExistsTest extends TestCase
{
    public function test_create_test_sdk(): void
    {
        $testsdk = TvmazeSDK::test(null, null);
        $this->assertNotNull($testsdk);
    }
}
