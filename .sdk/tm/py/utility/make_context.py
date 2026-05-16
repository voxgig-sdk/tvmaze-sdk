# Tvmaze SDK utility: make_context

from core.context import TvmazeContext


def make_context_util(ctxmap, basectx):
    return TvmazeContext(ctxmap, basectx)
