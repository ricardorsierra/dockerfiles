require 'resque-cleaner' #include cleaner
require 'resque-sliders' #include sliders

module Resque::Plugins
    ResqueCleaner::Limiter.default_maximum = 10_000
end
