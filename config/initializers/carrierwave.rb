CarrierWave.configure do |config|
  config.fog_credentials = {
    provider: "AWS",
    aws_access_key_id: "AKIAJW5OZISNWMBMPG7A",
    aws_secret_access_key: "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"
  }
  config.fog_directory = "thankful_app"
end