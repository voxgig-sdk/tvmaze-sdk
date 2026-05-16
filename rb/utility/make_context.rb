# Tvmaze SDK utility: make_context
require_relative '../core/context'
module TvmazeUtilities
  MakeContext = ->(ctxmap, basectx) {
    TvmazeContext.new(ctxmap, basectx)
  }
end
