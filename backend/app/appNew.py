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
        price = 'price'
        quantity = 'quantity'

    elif user_type == 'seller':
        data = buyer_data
        stakeholder_name = 'buyer_name'
        contact_number = 'contact_no'
        location_columns = ['latitude', 'longitude']
        id_column = 'buyer_id'
        price = 'price'
        quantity = 'quantity'
       
        
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
            "location_name": row['location_name'],
            "price": row[price],
            "quantity": row[quantity],
            "product_type": product_type,
            "banana_type": banana_type,
              
        })

    # Recommendation plan for buyers based on product type
    recommendation_plan = []
    if user_type == 'buyer':
        if product_type == 'Banana':
            recommendation_plan = [
                "Select ripe bananas with even yellow color and firm texture for immediate consumption.",
                "Consider buying slightly green bananas if you prefer them to ripen over a few days.",
                "Ensure proper handling and storage to maintain freshness.",
                "Explore a variety of recipes using bananas, such as banana bread, smoothies, and banana pudding.",
                "Use overripe bananas to make delicious banana pancakes or banana muffins.",
                "Freeze peeled bananas for later use in smoothies or as a healthy snack."
            ]
        elif product_type == 'Banana Blossom':
            recommendation_plan = [
                "Choose fresh, unblemished banana blossoms with tight petals and no signs of wilting.",
                "Use them in various culinary preparations like salads, stir-fries, or traditional dishes.",
                "Prepare the blossom by removing the tough outer layers and soaking it in water with lemon juice to prevent browning.",
                "Try making a traditional Thai or Filipino banana blossom salad with a zesty dressing.",
                "Explore vegetarian or vegan dishes using banana blossoms as a meat substitute due to their meaty texture.",
                "Include banana blossoms in curries, stews, or as a unique pizza topping for a distinctive flavor and texture."
            ]
        elif product_type == 'Banana Peel':
            recommendation_plan = [
            "Opt for organic or pesticide-free banana peels if possible.",
            "Utilize banana peels for composting, as they are rich in nutrients and can enhance soil fertility.",
            "Experiment with recipes that incorporate banana peels, such as smoothies or desserts, after thoroughly washing and removing any wax or pesticide residues.",
            "Make banana peel tea by boiling the peels and adding honey or spices for a soothing beverage with potential health benefits.",
            "Create a homemade banana peel fertilizer by blending peels and water, then using it to nourish your plants.",
            "Consider using banana peels as a natural, eco-friendly cleaning agent for polishing shoes or silverware.",
            ]
        elif product_type == 'Leaves':
            recommendation_plan = [
            "Ensure the leaves are fresh and free from damage or discoloration.",
            "Use banana leaves as natural food wraps for steaming, grilling, or baking dishes, imparting a distinct flavor.",
            "Explore traditional recipes that involve cooking or serving food in banana leaves, such as tamales, grilled fish, or rice cakes.",
            "Consider using banana leaves as eco-friendly, biodegradable plates or serving platters for outdoor events or picnics.",
            "Use dried and aged banana leaves for craft projects, such as making baskets, mats, or decorative items.",
            "Incorporate banana leaves into your garden mulch or compost to promote sustainability and enrich your soil."
            ]
        elif product_type == 'Banana Stem':
            recommendation_plan = [
            "Look for firm, unblemished banana stems with no signs of rot.",
            "Utilize banana stems in various dishes like salads, stir-fries, or curries.",
            "Prepare the stem by removing the tough outer layers and cutting it into desired shapes before cooking.",
            "Try making a refreshing South Indian banana stem salad (thoran) with coconut and spices.",
            "Incorporate banana stems into vegetarian or vegan recipes as a nutritious and fibrous ingredient.",
            "Experiment with blending banana stems into smoothies or juices for added health benefits.",
            "Consider using banana stems in soups and stews to impart a unique flavor and texture to your dishes.",
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


if __name__ == '__main__':
    app.run(debug=True)
