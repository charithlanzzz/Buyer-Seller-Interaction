#Get the inputs by the terminal and output the scatter plots
import os
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.neighbors import BallTree
from geopy.distance import geodesic

# Assuming the CSV files are placed in the 'data' directory
buyer_data_path = os.path.join(os.path.dirname(__file__), 'data', 'buyer_data.csv')
seller_data_path = os.path.join(os.path.dirname(__file__), 'data', 'seller_data.csv')

# Read the buyer and seller datasets from CSV files
buyer_data = pd.read_csv(buyer_data_path)
seller_data = pd.read_csv(seller_data_path)

# Get user input for user type
user_type = input("Are you a buyer or a seller? Enter 'buyer' or 'seller': ").strip()

# Get user input for product_type
product_type = input("Enter the product type (e.g., 'Banana'): ").strip()

# Check if the user selected "Banana" as the product type and ask for banana_type if so
if product_type.lower() == 'banana':
    banana_type = input("Enter the banana type (e.g., 'Seeni'): ").strip()
else:
    banana_type = None

# Fields specific to 'buyer' and 'seller'
if user_type == 'buyer':
    max_price = None
    min_quantity = None

    # Get user input for max_price
    max_price = float(input("Enter the maximum price (Per kg): "))

    # Get user input for min_quantity
    min_quantity = float(input("Enter the minimum quantity (kg): "))

elif user_type == 'seller':
    min_price = None
    max_quantity = None

    # Get user input for min_price
    min_price = float(input("Enter the minimum price (Per kg): "))

    # Get user input for max_quantity
    max_quantity = float(input("Enter the maximum quantity (kg): "))

# Get user input for location name
location_name = input("Enter the location name: ").strip()

# Get user input for the radius
radius = float(input("Enter the radius (in kilometers) for nearby stakeholders: "))

# Select the appropriate dataset based on user type
if user_type == 'buyer':
    data = seller_data
    stakeholder_name = 'seller_name'
    contact_number = 'contact_no'
    location_columns = ['latitude', 'longitude']
    id_column = 'seller_id'
    quantity_column = 'quantity'

    # Filter data based on user input
    filtered_data = data[(data['price'] <= max_price) &
                         (data['quantity'] >= min_quantity) &
                         (data['product_type'] == product_type)]

    if banana_type:
        filtered_data = filtered_data[filtered_data['banana_type'] == banana_type]

elif user_type == 'seller':
    data = buyer_data
    stakeholder_name = 'buyer_name'
    contact_number = 'contact_no'
    location_columns = ['latitude', 'longitude']
    id_column = 'buyer_id'
    quantity_column = 'quantity'

    # Filter data based on user input
    filtered_data = data[(data['price'] >= min_price) &
                         (data['quantity'] <= max_quantity) &
                         (data['product_type'] == product_type)]

    if banana_type:
        filtered_data = filtered_data[filtered_data['banana_type'] == banana_type]

# Check if there are any matching stakeholders
if not filtered_data.empty:
    # Retrieve latitude and longitude values for the given location name
    location_data = data.loc[data['location_name'] == location_name, location_columns + [id_column, stakeholder_name, contact_number]].values

    # Check if location data is available
    if len(location_data) > 0:
        # Get the latitude and longitude values
        latitude = location_data[0][0]
        longitude = location_data[0][1]

        # Create a BallTree using the latitude and longitude coordinates of stakeholders
        coordinates = filtered_data[location_columns].values
        tree = BallTree(coordinates, leaf_size=40)  # Adjust leaf_size parameter as needed

        # Perform a nearest neighbor search to find stakeholders within the specified radius
        indices = tree.query_radius([[latitude, longitude]], r=radius)[0]

        # Filter nearby stakeholders based on the obtained indices
        nearby_stakeholders = filtered_data.iloc[indices]

        # Calculate distances and filter by radius
        nearby_stakeholders['distance'] = nearby_stakeholders.apply(
            lambda row: geodesic((latitude, longitude), (row['latitude'], row['longitude'])).kilometers,
            axis=1
        )
        nearby_stakeholders = nearby_stakeholders[nearby_stakeholders['distance'] <= radius]

        # Plotting the nearby stakeholders' locations
        plt.figure(figsize=(10, 6))
        plt.scatter(nearby_stakeholders['latitude'], nearby_stakeholders['longitude'], c='green', label='Nearby Stakeholders', marker='o', s=50)
        plt.scatter(latitude, longitude, c='red', label='Given Location', marker='x', s=100)
        plt.xlabel('Latitude')
        plt.ylabel('Longitude')
        plt.title(f'Nearby Stakeholders within {radius} km')
        plt.legend()
        plt.show()
    else:
        print("Invalid location name entered.")
else:
    print("No matching stakeholders found based on the given requirements")
