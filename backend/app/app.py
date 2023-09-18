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

@app.route('/process_input', methods=['POST'])
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
    location_name = data['location_name']

    if 'location_name' not in data:
        return jsonify({"error": "Invalid location name entered."}), 400
    
    if int(data['radius']) < 0 :
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

 

    # Check if there are any matching stakeholders
    if not filtered_data.empty:
        # Retrieve latitude and longitude values for the given location name
        location_data = data.loc[data['location_name'].str.lower() == location_name.lower(), location_columns + [id_column, stakeholder_name, contact_number]].values

        # Check if location data is available
        if len(location_data) > 0:
            # Get the latitude and longitude values
            latitude = location_data[0][0]
            longitude = location_data[0][1]

            # Group data by location and calculate the distance from each group to the given location
            grouped_data = filtered_data.groupby(location_columns).apply(
                lambda g: g.assign(distance=g.apply(
                    lambda row: geodesic((latitude, longitude), (row['latitude'], row['longitude'])).km, axis=1)
                )
            )

            # Filter stakeholders within the specified radius or at the same location
            nearby_stakeholders = grouped_data.loc[(grouped_data['distance'] <= radius) | ((grouped_data['location_name'].str.lower() == location_name.lower()) & (grouped_data['latitude'] == latitude) & (grouped_data['longitude'] == longitude))].copy()

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
                elif product_type == 'Banana Blossom':
                    recommendation_plan = [
                        "Choose fresh, unblemished banana blossoms with tight petals and no signs of wilting.",
                        "Use them in various culinary preparations like salads, stir-fries, or traditional dishes.",
                        "Prepare the blossom by removing the tough outer layers and soaking it in water with lemon juice to prevent browning."
                    ]
                elif product_type == 'Banana Peel':
                    recommendation_plan = [
                        "Opt for organic or pesticide-free banana peels if possible.",
                        "Utilize banana peels for composting, as they are rich in nutrients and can enhance soil fertility.",
                        "Experiment with recipes that incorporate banana peels, such as smoothies or desserts, after thoroughly washing and removing any wax or pesticide residues."
                    ]
                elif product_type == 'Leaves':
                    recommendation_plan = [
                        "Ensure the leaves are fresh and free from damage or discoloration.",
                        "Use banana leaves as natural food wraps for steaming, grilling, or baking dishes, imparting a distinct flavor.",
                        "Explore traditional recipes that involve cooking or serving food in banana leaves."
                    ]
                elif product_type == 'Banana Stem':
                    recommendation_plan = [
                        "Look for firm, unblemished banana stems with no signs of rot.",
                        "Utilize banana stems in various dishes like salads, stir-fries, or curries.",
                        "Prepare the stem by removing the tough outer layers and cutting it into desired shapes before cooking."
                    ]
                else:
                    # Handle the case where product_type is not supported (e.g., return a 404 error)
                    return jsonify({"error": "Product type not supported"}), 404
            else:
                recommendation_plan = ["No specific recommendation plan available for sellers."]

            response = {
                "matching_stakeholders": matching_stakeholders,
                "recommendation_plan": recommendation_plan
            }

            return jsonify(response), 200

        else:
            return jsonify({"error": "Invalid location name entered."}), 400

    else:
        return jsonify({"error": "No matching stakeholders found based on the given requirements"}), 404


if __name__ == '__main__':
    app.run(debug=True)
