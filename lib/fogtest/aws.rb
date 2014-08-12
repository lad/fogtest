# encoding: UTF-8

module Fogtest
  class AWSProvider
    def initialize(config)
      @config = config
    end

    def name
      'AWS Provider'
    end
  end
end
