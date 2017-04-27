require 'simplecov'
SimpleCov.start 'rails'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/reporters'
require 'contexts'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  # fixtures :all

  # Include all the Factory Girls for 
  include Contexts

  # Helper Methods
  def deny(condition)
    # a simple transformation to increase readability IMO
    assert !condition
  end

  # Runs assert_difference with a number of conditions and varying difference
  # counts.
  #
  # Call as follows:
  #
  # assert_differences([['Model1.count', 2], ['Model2.count', 3]])
  #
  def assert_differences(expression_array, message = nil, &block)
    b = block.send(:binding)
    before = expression_array.map { |expr| eval(expr[0], b) }

    yield

    expression_array.each_with_index do |pair, i|
      e = pair[0]
      difference = pair[1]
      error = "#{e.inspect} didn't change by #{difference}"
      error = "#{message}\n#{error}" if message
      assert_equal(before[i] + difference, eval(e, b), error)
    end
  end

  # Uploads file and return the uploaded file object
  def upload_file(file_name)
    uploaded_file = ActionDispatch::Http::UploadedFile.new({
        :tempfile => File.new(Rails.root.join("test/fixtures/files/#{file_name}"))
    })
    uploaded_file.original_filename = file_name
    uploaded_file
  end

end
