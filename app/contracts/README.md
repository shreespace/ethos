Explanation:
Hotel Structure:

Each hotel has an id, name, location, pricePerNight, and owner (the address that added the hotel).
Booking Structure:

Each booking has an id, the user address (the one making the booking), the hotelId, check-in and check-out dates, and a flag to indicate if the booking is paid.
Functions:

addHotel: Allows hotel owners to add a new hotel.

bookHotel: Allows users to book a hotel. Users must send the value (equivalent to the price of one night).

getHotel: Fetch details of a specific hotel.

getUserBookings: Retrieves the bookings made by the user.

updateHotel: Allows the hotel owner to update the hotel information.


Events:

a. HotelAdded: Emits whenever a new hotel is added to the system.

 b. HotelBooked: Emits whenever a booking is confirmed.

----------------------------------------------------------------------------------------------------

How to Deploy the Contract
You can deploy this contract using Hardhat or Truffle.

Using Hardhat:
1. Compile the Contract:

Inside your project directory, create a contracts folder and save the HotelBooking.sol file in it.
Compile the contract:

     npx hardhat compile

2. Deploy the Contract: Create a deployment script in the contracts folder.
   
a. deploy.js:

b. Run the deployment script:

         npx hardhat run scripts/deploy.js --network localhost


Using Truffle:
1. Compile the Contract:

Place the HotelBooking.sol contract inside the contracts folder.
Compile the contract:

          truffle compile

2. Deploy the Contract: Create a migration file in the migrations folder.

     a. 2_deploy_contracts.js:
   
     b. Run the deployment:

       truffle migrate
