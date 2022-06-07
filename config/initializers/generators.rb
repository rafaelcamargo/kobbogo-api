Rails.application.config.generators do |g|
  # Set UUID as primary id for every new model
  g.orm :active_record, primary_key_type: :uuid
end
