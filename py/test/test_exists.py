# ProjectName SDK exists test

import pytest
from tvmaze_sdk import TvmazeSDK


class TestExists:

    def test_should_create_test_sdk(self):
        testsdk = TvmazeSDK.test(None, None)
        assert testsdk is not None
