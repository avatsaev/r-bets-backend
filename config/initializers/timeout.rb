Rack::Timeout.timeout = ENV.fetch('REQUEST_TIMEOUT') { 3 }.to_i
