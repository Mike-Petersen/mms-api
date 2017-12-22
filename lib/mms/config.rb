module MMS
  class Config
    default = {
      username: proc { nil },
      apikey: proc { nil },
      apiurl: proc { [api_protocol, '://', api_host, ':', api_port, api_path, '/', api_version].join.to_s },
      limit: proc { 10 },
      api_protocol: proc { 'https' },
      api_host: proc { 'mms.mongodb.com' },
      api_port: proc { '443' },
      api_path: proc { '/api/public' },
      api_version: proc { 'v1.0' },
      default_group_id: proc { nil },
      default_cluster_id: proc { nil },
      config_path: proc { Dir.home + '/.mms-api' }
    }

    default.each do |key, value|
      define_method(key) do
        default[key] = instance_eval(&value) if default[key].equal?(value)
        default[key]
      end
      define_method("#{key}=") do |val|
        default[key] = val
      end
    end
  end
end
