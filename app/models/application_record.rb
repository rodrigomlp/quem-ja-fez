class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true # PERGUNTA: what the fuck is this?
end
