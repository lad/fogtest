# encoding: UTF-8

module Fogtest
  class AWSProvider
    def initialize(config)
      @config = config
    end

    def name
      'AWS Provider'
    end

    def connect
      @client ||= Fog::Compute.new(provider: 'AWS',
                                   aws_access_key_id: @config['aws_access_key_id'],
                                   aws_secret_access_key: @config['aws_secret_access_key'],
                                   region: @config['region'])
    end

    def create_instance
    end

    def delete_instance
    end

    def list_images
      #@client.images.all('tag:Silo' => 'vdcl-24')
      @client.images.all
    end

    def list_instances
      @client.servers.all
    end

    def list_flavors
      @client.flavors
    end

    def get_image(image_id)
    end

    def get_instance(instance_id)
    end

    def get_flavor(flavor_id)
    end

  end
end

=begin

def aws_client
  Fog::Compute.new(provider: 'AWS',
                   aws_access_key_id: AWS_ACCESS_KEY,
                   aws_secret_access_key: AWS_SECRET_KEY,
                   region: REGION)
end

def create_client
  aws_client
end

def create_server(client = nil, wait = true)
  client ||= create_client
  server = client.servers.create(image_id: IMAGE_ID,
                                 key_name: KEY_NAME,
                                 subnet_id: SUBNET_ID,
                                 instance_type: INSTANCE_TYPE,
                                 private_ip_address: PRIVATE_IP_ADDRESS)
  # This waits for the new instance ID to be known to the EC2 API. It does not
  # wait for the instance to boot, this is just about being able to use the
  # instance ID immediately in further calls to the EC2 API.
  server.wait_for { ready? } if wait
  server
end

def destroy_server(server)
  server.destroy
end

def create_filters(tags)
  if tags
    fail unless tags.class == Hash
    filters = tags.reduce({}) do |hsh, val|
      k, v = val
      hsh["tag:#{k}"] = v
      hsh
    end
  else
    filters = nil
  end
end

def list_images(client = nil, tags = nil)
  client ||= create_client
  filters = create_filters(tags)
  client.images.all(filters)
end

def list_instances(client = nil, tags = nil)
  client ||= create_client
  filters = create_filters(tags)
  client.servers.all(filters)
end

=end

