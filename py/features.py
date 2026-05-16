# Tvmaze SDK feature factory

from feature.base_feature import TvmazeBaseFeature
from feature.test_feature import TvmazeTestFeature


def _make_feature(name):
    features = {
        "base": lambda: TvmazeBaseFeature(),
        "test": lambda: TvmazeTestFeature(),
    }
    factory = features.get(name)
    if factory is not None:
        return factory()
    return features["base"]()
