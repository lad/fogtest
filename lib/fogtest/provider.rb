# encoding: UTF-8

module Fogtest
  class UnknownProviderException < RuntimeError; end
  class ConnectException < RuntimeError; end
  class NoSuchId < RuntimeError; end

  class Provider
    NAMES = ['aws', 'openstack']

    def self.create(name, config)
      case name.downcase
      when 'aws'
        AWSProvider.new(config)
      when 'openstack'
        OpenstackProvider.new(config)
      else
        fail UnknownProviderException, name
      end
    end
  end
end
