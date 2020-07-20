require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  setup do
    @company = companies(:hometown_painting)
  end

  def test_update_company_with_invalid_email_address
    @company.email = "test@test.com"

    refute @company.valid?
    assert_equal @company.errors.messages[:email], ["should only be a @getmainstreet.com domain"]
  end

  def test_update_company_with_valid_email_address
    @company.email = "test@getmainstreet.com"

    assert @company.valid?
    assert_equal @company.errors.messages[:email], []
  end

  def test_update_company_with_blank_email_address
    @company.email = ""

    assert @company.valid?
    assert_equal @company.errors.messages[:email], []
  end

  def test_create_company_with_invalid_email_address
    company = Company.new(name: "new company", email: "test@test.com")

    refute company.save
    assert_equal company.errors.messages[:email], ["should only be a @getmainstreet.com domain"]
  end

  def test_create_company_with_valid_email_address
    company = Company.new(name: "new company", email: "test@getmainstreet.com")

    assert company.save
    assert_equal company.errors.messages[:email], []
  end

  def test_create_company_with_blank_email_address
    company = Company.new(name: "new company")

    assert company.save
    assert_equal company.errors.messages[:email], []
  end
end
