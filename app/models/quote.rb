class Quote
  include Mongoid::Document

  field :page, type: String
  field :timestamp, type: DateTime
  field :tag, type: String

end