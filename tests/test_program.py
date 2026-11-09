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

from central_setup.central_setup import ( check_internet_connection )
from common_setup import pre_test_setup
from check_welcome import welcome_test

def test_all():

    # Online testing
    if check_internet_connection():
        test_outputs, test_points_awarded, test_feedback, test_response_data = pre_test_setup()
        assert test_response_data['totalPointsAwarded'] == test_response_data['totalPointsPossible'], test_feedback

    # Offline testing
    else :
        welcome_test()
