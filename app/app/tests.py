"""
Tests for no_repeat
"""
from django.test import SimpleTestCase

from app.no_repeat import del_repeat, most_common


class TestsPa(SimpleTestCase):

    def test_no_repeat(self):
        """Test for function del_repeat."""
        args = [1, 1, 1, 2, 3, 2, 4, 4, 5, 6, 7, 8, 8, 8, 7, 9]
        res = del_repeat(args)

        self.assertEqual(res, [1, 2, 3, 4, 5, 6, 7, 8, 9])

    def test_most_common(self):
        """Test for most common"""
        args = ' the only dream of to man, is win his fights... remember, the dream is most big. We find the light, keep fighting for the dream'
        res = most_common(args)

        self.assertEqual(res, ['the', 'dream', 'is'])
