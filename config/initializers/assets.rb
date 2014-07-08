Rails.application.configure do
  config.assets.precompile += %w( groups.js lessons.js pages.js profiles.js)
end