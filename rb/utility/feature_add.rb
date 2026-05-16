# Tvmaze SDK utility: feature_add
module TvmazeUtilities
  FeatureAdd = ->(ctx, f) {
    ctx.client.features << f
  }
end
