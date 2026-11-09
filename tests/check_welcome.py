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

import subprocess
import sys
import os
from difflib import SequenceMatcher
from common_setup import run_test

def welcome_test():
    script_path = os.path.join(os.path.dirname(__file__), '..', 'welcome.py')
    script_path = os.path.abspath(script_path)

    result = subprocess.run(
        [sys.executable, script_path],
        capture_output=True,
        text=True
    )

    output = result.stdout.strip()
    assert output, "\U0000274C welcome.py does not print anything. Hint: make sure to use the print() function!"

    expected = '''
==================================================
                    VitalLink
  Your partner in smarter, connected healthcare
==================================================

Welcome!
We're excited to support you on your health journey.

With VitalLink, you can stay connected with providers,
track important health information, and access tools
designed to help you live well every day.
'''.strip()

    # Calculate similarity ratio
    similarity = SequenceMatcher(None, output, expected).ratio()

    assert similarity >= 0.8, (
        f"\U0000274C welcome.py does not print out the correct welcome message.\n"
        f"Make sure that running `py welcome.py` will print the following:\n"
		f"\n{expected}\n"
    )

def test_welcome_online():
	run_test("check_welcome", "Check for a welcome message", "\U0000274C welcome.py does not print out the correct welcome message.")
