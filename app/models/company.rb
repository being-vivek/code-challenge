class Company < ApplicationRecord
  has_rich_text :description

  EMAIL_REGEX = /\w+@getmainstreet\.{1}com/.freeze
  validates :email, format: EMAIL_REGEX, if: -> { email.present? }

  before_save :update_location, if: :will_save_change_to_zip_code?

  private

  def update_location
    location = ZipCodes.identify(zip_code)
    assign_attributes({
                        state: location&.fetch(:state_code),
                        city: location&.fetch(:city)
                      })
  end
end
