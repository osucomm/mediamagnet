class Keyword < ActiveRecord::Base
  enum category: { audience: 0, college: 1, location: 2 }
end
