# GdUnit generated TestSuite
class_name TTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://Util/T.gd'


func test_get_elapsed_time_string() -> void:
	assert_str(T.get_elapsed_time_string(10)).is_equal("00:00:00:10")
	assert_str(T.get_elapsed_time_string(1000)).is_equal("00:00:01:00")
	assert_str(T.get_elapsed_time_string(1001)).is_equal("00:00:01:01")
	assert_str(T.get_elapsed_time_string(60000)).is_equal("00:01:00:00")
	assert_str(T.get_elapsed_time_string(60001)).is_equal("00:01:00:01")
	assert_str(T.get_elapsed_time_string(61000)).is_equal("00:01:01:00")
	assert_str(T.get_elapsed_time_string(61001)).is_equal("00:01:01:01")
	assert_str(T.get_elapsed_time_string(3600001)).is_equal("01:00:00:01")
