class Company < ApplicationRecord
  has_rich_text :description

  EMAIL_REGEX = /\w+@getmainstreet\.{1}com/.freeze
  validates :email, :format => EMAIL_REGEX, if: lambda { self.email.present? }
end
