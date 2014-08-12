# encoding: UTF-8

module Fogtest
  class OpenstackProvider
    attr_accessor :client

    def initialize(config)
      @config = config
    end

    def name
      'Openstack Provider'
    end

    def connect
      @client ||= Fog::Compute.new(provider: 'openstack',
                                   openstack_tenant: @config['openstack_tenant'],
                                   openstack_api_key: @config['openstack_api_key'],
                                   openstack_username: @config['openstack_username'],
                                   openstack_auth_url: @config['openstack_auth_url'])
    rescue Excon::Errors::Unauthorized => e
      fail Fogtest::ConnectException, e.to_s
    end

    def create_instance(name, image_id, flavor_id)
      instance = @client.servers.create(name: name, image_ref: image_id,
                                        flavor_ref: flavor_id)
      instance.wait_for { ready? }
      instance
    end

    def delete_instance(instance_id)
      server = @client.servers.get(instance_id)
      fail NoSuchId if server.nil?
      server.destroy
    end

    def list_images
      @client.images.all
    end

    def list_instances
      @client.servers.all
    end

    def list_flavors
      @client.flavors
    end

    def get_image(image_id)
      image = @client.images.get(image_id)
      fail Fogtest::NoSuchId if image.nil?
      image
    end

    def get_instance(instance_id)
      instance = @client.servers.get(instance_id)
      fail Fogtest::NoSuchId if instance.nil?
      instance
    end

    def get_flavor(flavor_id)
      flavor = @client.flavors.get(flavor_id)
      fail Fogtest::NoSuchId if flavor.nil?
      flavor
    end
  end
end

