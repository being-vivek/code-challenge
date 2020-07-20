require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  setup do
    @company = companies(:hometown_painting)
  end

  def test_update_company_with_invalid_email_address
    @company.email = 'test@test.com'

    refute @company.valid?
    assert_equal @company.errors.messages[:email], ['should only be a @getmainstreet.com domain']
  end

  def test_update_company_with_valid_email_address
    @company.email = 'test@getmainstreet.com'

    assert @company.valid?
    assert_equal @company.errors.messages[:email], []
  end

  def test_update_company_with_blank_email_address
    @company.email = ''

    assert @company.valid?
    assert_equal @company.errors.messages[:email], []
  end

  def test_create_company_with_invalid_email_address
    company = Company.new(name: 'new company', email: 'test@test.com')

    refute company.save
    assert_equal company.errors.messages[:email], ['should only be a @getmainstreet.com domain']
  end

  def test_create_company_with_valid_email_address
    company = Company.new(name: 'new company', email: 'test@getmainstreet.com')

    assert company.save
    assert_equal company.errors.messages[:email], []
  end

  def test_create_company_with_blank_email_address
    company = Company.new(name: 'new company')

    assert company.save
    assert_equal company.errors.messages[:email], []
  end

  def test_create_company_with_valid_zip_code
    company = Company.new(name: 'new company', zip_code: '93009')

    assert company.save
    location = ZipCodes.identify(company.zip_code)
    assert_equal location.fetch(:city), company.city
    assert_equal location.fetch(:state_code), company.state
  end

  def test_create_company_with_invalid_zip_code
    company = Company.new(name: 'new company', zip_code: '930091')

    assert company.save
    assert_equal nil, company.city
    assert_equal nil, company.state
  end

  def test_update_company_with_valid_zip_code
    company = Company.new(name: 'new company', zip_code: '930091')

    assert company.save
    assert_equal nil, company.city
    assert_equal nil, company.state

    company.update(zip_code: '93009')
    location = ZipCodes.identify(company.zip_code)
    assert_equal location.fetch(:city), company.city
    assert_equal location.fetch(:state_code), company.state
  end

  def test_update_company_with_invalid_zip_code
    company = Company.new(name: 'new company', zip_code: '93009')

    assert company.save
    location = ZipCodes.identify(company.zip_code)
    assert_equal location.fetch(:city), company.city
    assert_equal location.fetch(:state_code), company.state

    company.update(zip_code: '930091')
    location = ZipCodes.identify(company.zip_code)
    assert_equal nil, company.city
    assert_equal nil, company.state
  end
end
