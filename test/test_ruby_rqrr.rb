# frozen_string_literal: true

require "test_helper"

class TestRubyRqrr < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RubyRqrr::VERSION
  end

  def test_it_can_read_github_qr_code
    qr = RubyRqrr.detect_qrs_in_image(fixture_path("github.gif"))
    assert_equal qr, ["https://github.com/WanzenBug/rqrr"]
  end

  def test_it_can_read_number_qr_codes
    qr = RubyRqrr.detect_qrs_in_image(fixture_path("number.gif"))
    expected_values = %w[1234567891011121314151617181920]
    assert_equal qr, expected_values
  end

  def test_it_can_read_incomplete_rqrr_qr_codes
    qr = RubyRqrr.detect_qrs_in_image(fixture_path("rqrr_incomplete.gif"))
    expected_values = %w[rqrr]
    assert_equal qr, expected_values
  end

  def test_it_can_read_rqrr_qr_codes
    qr = RubyRqrr.detect_qrs_in_image(fixture_path("rqrr.gif"))
    expected_values = %w[rqrr]
    assert_equal qr, expected_values
  end

  def test_it_can_read_gogh_qr_code
    qr = RubyRqrr.detect_qrs_in_image(fixture_path("full/gogh.jpg"))
    expected_values = %w[https://github.com/WanzenBug/rqrr 1234567891011121314151617181920 rqrr]
    assert_equal qr, expected_values
  end

  def test_it_can_read_multiple_qr_codes
    qr = RubyRqrr.detect_qrs_in_image(fixture_path("full/multiple.png"))
    expected_values = [
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariat",
      "ur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea comm",
      "odo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    ]
    assert_equal qr, expected_values
  end

  def test_it_can_read_multiple_rotated_qr_codes
    qr = RubyRqrr.detect_qrs_in_image(fixture_path("full/multiple_rotated.png"))
    expected_values = [
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariat",
      "ur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea comm",
      "odo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
    ]
    assert_equal qr, expected_values
  end

  def test_it_can_read_superlong_qr_codes
    qr = RubyRqrr.detect_qrs_in_image(fixture_path("full/superlong.gif"))
    expected_values = %w[
      superlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdatasuperlongdata
    ]
    assert_equal qr, expected_values
  end

  def test_raises_error_when_file_does_not_exist
    assert_raises IOError do
      RubyRqrr.detect_qrs_in_image(fixture_path("full/superlong.png"))
    end
  end

  def test_raises_error_when_data_encoding_is_invalid
    assert_raises RubyRqrr::QrParseError do
      RubyRqrr.detect_qrs_in_image(fixture_path("errors/data_ecc.png"))
    end
  end

  def test_raises_error_when_format_encoding_is_invalid
    assert_raises RubyRqrr::QrParseError do
      RubyRqrr.detect_qrs_in_image(fixture_path("errors/format_ecc.png"))
    end
  end

  def test_raises_error_when_version_is_invalid
    assert_raises RubyRqrr::QrParseError do
      RubyRqrr.detect_qrs_in_image(fixture_path("errors/invalid_version.gif"))
    end
  end

  def test_it_does_not_panic_1
    qr = RubyRqrr.detect_qrs_in_image(fixture_path("errors/should-not-panic-1.jpg"))
    expected_values = %w[http://m.liantu.com/]
    assert_equal qr, expected_values
  end

  def test_it_does_not_panic_2
    assert_raises RubyRqrr::QrParseError do
      RubyRqrr.detect_qrs_in_image(fixture_path("errors/should-not-panic-2.jpg"))
    end
  end

  private

  def fixture_path(filename)
    File.join(File.dirname(__FILE__), "fixtures", "images", filename)
  end
end
