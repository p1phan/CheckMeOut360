S3_CONFIG = YAML.load_file(Rails.root.join('config', 'amazon_s3.yml'))[Rails.env]

CarrierWave.configure do |config|
  config.storage              = :s3
  config.s3_access_policy     = :public_read_write
  config.root = Rails.root.join('tmp')
  config.cache_dir = 'carrierwave'
  config.s3_access_key_id     = S3_CONFIG['access_key_id']
  config.s3_secret_access_key = S3_CONFIG['secret_access_key']
  config.s3_bucket            = S3_CONFIG['bucket']
end