# frozen_string_literal: true

uri = URI.parse('redis://localhost:6379/1')
$redis = Redis.new(host: uri.host, port: uri.port)
