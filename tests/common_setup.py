# *****************************************************************************
# *                                                                           *
# *   IMPORTANT: DO NOT MODIFY THIS FILE                                      *
# *                                                                           *
# *   This testing file is provided to help you check the functionality of    *
# *   your code and understand the requirements for this assignment.          *
# *                                                                           *
# *   Please review the tests carefully to understand what is expected, but   *
# *   DO NOT make any changes to this file. Modifying this file will          *
# *   interfere with the grading system, lead to incorrect results, and       *
# *   will be flagged as cheating.                                            *
# *                                                                           *
# *   Focus on writing your own code to meet the requirements outlined in the *
# *   tests.                                                                  *
# *                                                                           *
# *****************************************************************************

import requests
import json
import sys
sys.path.append('..')
from central_setup.central_setup import ( execute_logic, run_single_test, run_program )

program_name = 'welcome.py' # The name of the file the student is assigned to write
test_file = 'tests/check_welcome.py' # The name of the test file to check the student code

def run_test(test_name, test_description, error_message):
    run_single_test(test_name, test_description, error_message, pre_test_setup)

# Logic functions for each test
def logic_welcome():
    return run_program([], program_name)

def pre_test_setup(test_name=None):
    test_outputs = { }
    test_points_awarded = {}
    test_feedback = ""
    test_response_data = None

    # Get only the logic for the specified test, or all tests if no specific test is provided
    if test_name:
        if test_name == "check_welcome":
            test_outputs["check_welcome"] = logic_welcome()
    else:
        test_outputs = {
            "check_welcome": logic_welcome(),
        }

    try:
        # Read the contents of the files
        with open(program_name, 'r') as f:
            student_code = f.read()
        with open(test_file, 'r') as f:
            pytest_code = f.read()
        with open('.github/classroom/autograding.json', 'r') as f:
            autograding_config = json.load(f)

        # Pass the logic to the central_setup module
        test_outputs, test_points_awarded, test_feedback, test_response_data = execute_logic(
            test_name, test_outputs, student_code, pytest_code, autograding_config
        )

    except (requests.exceptions.RequestException, json.JSONDecodeError) as e:
        print(f"API call failed: {e}")
        print("Proceeding without API response. Run the test again with a working API to receive more user-friendly feedback.")

    return test_outputs, test_points_awarded, test_feedback, test_response_data
