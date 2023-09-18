import os
import unittest
import json
from app import app

class YourAppTestCase(unittest.TestCase):
    def setUp(self):
        # Set up a test client
        self.app = app.test_client()

    def test_hello_route(self):
        # Test the '/hello' route
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data.decode(), 'Hello, Flask World!')

    def test_invalid_user_type(self):
        # Test a case with an invalid user type
        data = {
            "user_type": "invalid_type",
            "product_type": "Banana",
            "banana_type": "",
            "min_price": 100,
            "max_quantity": 1000,
            "radius": 10,
            "location_name": "Test Location"
        }
        response = self.app.post('/process_input', json=data)
        self.assertEqual(response.status_code, 400)
        data = json.loads(response.data.decode())
        self.assertEqual(data["error"], "Invalid user type entered.")

    def test_valid_user_and_product_type(self):
        # Test a case with valid user and product types
        data = {
            "user_type": "seller",
            "product_type": "Banana",
            "banana_type": "Seeni",
            "min_price": 100,
            "max_quantity": 1000,
            "radius": 10,
            "location_name": "Colombo"
        }
        response = self.app.post('/process_input', json=data)
        self.assertEqual(response.status_code, 200)
        response_data = json.loads(response.data.decode())
        self.assertIn("matching_stakeholders", response_data)
        self.assertIn("recommendation_plan", response_data)
        

    def test_ivalid_radius(self):
    # Test a case with an invalid radius (negative value)
        data = {
            "user_type": "seller",
            "product_type": "Banana",
            "banana_type": "Seeni",
            "min_price": 100,
            "max_quantity": 1000,
            "radius": -5,  # Provide a negative value for testing
            "location_name": "Colombo"
        }
        response = self.app.post('/process_input', json=data)
        self.assertEqual(response.status_code, 400)
        data = json.loads(response.data.decode())
        self.assertEqual(data["error"], "Invalid radius value.")



    def test_missing_location_name(self):
    # Test a case with missing location name
        data = {
            "user_type": "seller",
            "product_type": "Banana",
            "banana_type": "Seeni",
            "min_price": 100,
            "max_quantity": 1000,
            "radius": 10,
            "location_name": "Test"
        }
        response = self.app.post('/process_input', json=data)
        self.assertEqual(response.status_code, 400)
        data = json.loads(response.data.decode())
        self.assertEqual(data["error"], "Invalid location name entered.")

    def test_valid_location_name(self):
    # Test a case with a valid location name
        data = {
            "user_type": "seller",
            "product_type": "Banana",
            "banana_type": "Seeni",
            "min_price": 100,
            "max_quantity": 1000,
            "radius": 10,
            "location_name": "Colombo"
        }
        response = self.app.post('/process_input', json=data)
        self.assertEqual(response.status_code, 200)
        response_data = json.loads(response.data.decode())
        self.assertIn("matching_stakeholders", response_data)
        self.assertIn("recommendation_plan", response_data)

    

if __name__ == '__main__':
    unittest.main()
