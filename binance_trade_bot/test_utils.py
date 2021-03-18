import unittest

from .utils import *


class TestUtils(unittest.TestCase):

    def test_first(self):
        """
        Test first with a defined iterable
        """
        alltickers = [
            {'symbol': 'AAA', 'price': 1.001},
            {'symbol': 'BBB', 'price': 2.002}
        ]
        result1 = first(
            alltickers, condition=lambda x: x["symbol"] == 'AAA')
        self.assertEqual(result1, alltickers[0])
        result2 = first(
            alltickers, condition=lambda x: x["symbol"] == 'BBB')
        self.assertEqual(result2, alltickers[1])

    def test_get_market_ticker_price_from_list(self):
        """
        Test get_market_ticker_price_from_list with known data
        """
        alltickers = [
            {'symbol': 'AAA', 'price': 1.001},
            {'symbol': 'BBB', 'price': 2.002}
        ]
        result = get_market_ticker_price_from_list(alltickers, 'BBB')
        self.assertEqual(result, 2.002)
