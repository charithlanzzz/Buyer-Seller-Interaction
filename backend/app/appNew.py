import os
from flask import Flask, request, jsonify
from flask_cors import CORS
from geopy.distance import geodesic
import pandas as pd

app = Flask(__name__)
CORS(app)

# Assuming the CSV files are placed in the 'data' directory
buyer_data_path = os.path.join(os.path.dirname(__file__), 'data', 'buyer_data.csv')
seller_data_path = os.path.join(os.path.dirname(__file__), 'data', 'seller_data.csv')

# Read the buyer and seller datasets from CSV files
buyer_data = pd.read_csv(buyer_data_path)
seller_data = pd.read_csv(seller_data_path)

@app.route('/')
def hello():
    return 'Hello, Flask World!'

@app.route('/process_input_new', methods=['POST'])
def process_input():
    data = request.json

    user_type = data['user_type']
    product_type = data['product_type']
    banana_type = data.get('banana_type', 'Seeni')
    min_price = float(data.get('min_price', 0))  # Default to 0 if not provided
    max_price = float(data.get('max_price', float('inf')))  # Default to infinity if not provided
    min_quantity = float(data.get('min_quantity', 0))
    max_quantity = float(data.get('max_quantity', float('inf')))
    radius = float(data['radius'])
    latitude = float(data['latitude'])  # User-specified latitude
    longitude = float(data['longitude'])  # User-specified longitude

    if radius < 0:
        return jsonify({"error": "Invalid radius value."}), 400
    
    # Select the appropriate dataset based on user type
    if user_type == 'buyer':
        data = seller_data
        stakeholder_name = 'seller_name'
        contact_number = 'contact_no'
        location_columns = ['latitude', 'longitude']
        id_column = 'seller_id'
    elif user_type == 'seller':
        data = buyer_data
        stakeholder_name = 'buyer_name'
        contact_number = 'contact_no'
        location_columns = ['latitude', 'longitude']
        id_column = 'buyer_id'
    else:
        return jsonify({"error": "Invalid user type entered."}), 400

    # Filter data based on price, product type, and quantity range
    if user_type == 'buyer':
        filtered_data = data[(data['price'] <= max_price) &
                             (data['quantity'] >= min_quantity) &
                             (data['product_type'] == product_type)].copy()
    else:
        filtered_data = data[(data['price'] >= min_price) &
                             (data['quantity'] <= max_quantity) &
                             (data['product_type'] == product_type)].copy()

    # Check if banana_type is provided and product_type is "Banana"
    if 'banana_type' in data and product_type == 'Banana':
        filtered_data = filtered_data[filtered_data['banana_type'] == banana_type]

    # Calculate the distance between stakeholders' locations and the specified latitude and longitude
    filtered_data['distance'] = filtered_data.apply(
        lambda row: geodesic((latitude, longitude), (row['latitude'], row['longitude'])).km,
        axis=1
    )

    # Filter stakeholders within the specified radius
    nearby_stakeholders = filtered_data[filtered_data['distance'] <= radius].copy()

    # Create a list of matching stakeholders
    matching_stakeholders = []
    for _, row in nearby_stakeholders.iterrows():
        matching_stakeholders.append({
            "id": row[id_column],
            "name": row[stakeholder_name],
            "contact_number": row[contact_number],
            "location_name": row['location_name']
        })

    # Recommendation plan for buyers based on product type
    recommendation_plan = []
    if user_type == 'buyer':
        if product_type == 'Banana':
            recommendation_plan = [
                "Select ripe bananas with even yellow color and firm texture for immediate consumption.",
                "Consider buying slightly green bananas if you prefer them to ripen over a few days.",
                "Ensure proper handling and storage to maintain freshness."
            ]
        # Add recommendations for other product types as needed
    else:
        recommendation_plan = ["No specific recommendation plan available for sellers."]

    response = {
        "matching_stakeholders": matching_stakeholders,
        "recommendation_plan": recommendation_plan
    }

    return jsonify(response), 200

if __name__ == '__main__':
    app.run(debug=True)
