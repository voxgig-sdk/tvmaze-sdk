# Tvmaze SDK feature factory

require_relative 'feature/base_feature'
require_relative 'feature/test_feature'


module TvmazeFeatures
  def self.make_feature(name)
    case name
    when "base"
      TvmazeBaseFeature.new
    when "test"
      TvmazeTestFeature.new
    else
      TvmazeBaseFeature.new
    end
  end
end
