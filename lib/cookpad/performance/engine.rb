module Cookpad
  module Performance
    class Engine < ::Rails::Engine
      isolate_namespace Cookpad::Performance
    end
  end
end
