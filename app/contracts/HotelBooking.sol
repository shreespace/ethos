// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract HotelBooking {
    
    struct Hotel {
        uint id;
        string name;
        string location;
        uint pricePerNight;
        address payable owner;
        bool isAvailable;
    }

    struct Booking {
        uint hotelId;
        address guest;
        uint checkInDate;
        uint checkOutDate;
        bool isPaid;
    }

    uint public hotelCount = 0;
    mapping(uint => Hotel) public hotels;
    mapping(uint => Booking) public bookings;
    uint public bookingCount = 0;

    // Events
    event HotelAdded(uint id, string name, string location, uint pricePerNight, address owner);
    event HotelBooked(uint bookingId, uint hotelId, address guest, uint checkInDate, uint checkOutDate, bool isPaid);

    // Modifier: Only the hotel owner can manage hotel-related tasks
    modifier onlyHotelOwner(uint _hotelId) {
        require(hotels[_hotelId].owner == msg.sender, "You are not the owner of this hotel");
        _;
    }

    // Modifier: Hotel must be available for booking
    modifier isHotelAvailable(uint _hotelId) {
        require(hotels[_hotelId].isAvailable, "Hotel is not available for booking");
        _;
    }

    // Add a new hotel
    function addHotel(string memory _name, string memory _location, uint _pricePerNight) public {
        hotelCount++;
        hotels[hotelCount] = Hotel(hotelCount, _name, _location, _pricePerNight, payable(msg.sender), true);
        emit HotelAdded(hotelCount, _name, _location, _pricePerNight, msg.sender);
    }

    // Book a hotel
    function bookHotel(uint _hotelId, uint _checkInDate, uint _checkOutDate) public payable isHotelAvailable(_hotelId) {
        Hotel storage hotel = hotels[_hotelId];

        // Ensure the correct price is paid for the stay duration
        uint totalPrice = (hotel.pricePerNight) * (_checkOutDate - _checkInDate) / 1 days;
        require(msg.value == totalPrice, "Incorrect value sent for booking");

        // Create the booking
        bookingCount++;
        bookings[bookingCount] = Booking(_hotelId, msg.sender, _checkInDate, _checkOutDate, true);

        // Transfer payment to the hotel owner via escrow
        hotel.owner.transfer(msg.value);

        emit HotelBooked(bookingCount, _hotelId, msg.sender, _checkInDate, _checkOutDate, true);
    }

    // Mark hotel as unavailable (e.g., if hotel owner wants to disable it temporarily)
    function setHotelAvailability(uint _hotelId, bool _isAvailable) public onlyHotelOwner(_hotelId) {
        hotels[_hotelId].isAvailable = _isAvailable;
    }

    // Get details of a specific hotel
    function getHotel(uint _hotelId) public view returns (uint, string memory, string memory, uint, address, bool) {
        Hotel memory hotel = hotels[_hotelId];
        return (hotel.id, hotel.name, hotel.location, hotel.pricePerNight, hotel.owner, hotel.isAvailable);
    }

    // Get details of a specific booking
    function getBooking(uint _bookingId) public view returns (uint, address, uint, uint, bool) {
        Booking memory booking = bookings[_bookingId];
        return (booking.hotelId, booking.guest, booking.checkInDate, booking.checkOutDate, booking.isPaid);
    }
}
