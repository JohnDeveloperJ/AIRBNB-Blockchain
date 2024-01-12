// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";

contract Airbnb is Ownable {
    uint256 private counter;

    struct RentalInfo {
        string name;
        string city;
        int256 lat;
        int256 long;
        string unoDescription;
        string dosDescription;
        string imgUrl;
        uint256 maxGuests;
        uint256 pricePerDay;
        string[] datesBooked;
        uint256 id;
    }

    event RentalCreated(
        uint256 indexed id,
        string name,
        string city,
        int256 lat,
        int256 long,
        string unoDescription,
        string dosDescription,
        string imgUrl,
        uint256 maxGuests,
        uint256 pricePerDay,
        string[] datesBooked
    );

    event NewDatesBooked(
        uint256 indexed id,
        string[] datesBooked
    );

    mapping(uint256 => RentalInfo) public rentals;

    constructor() Ownable(msg.sender) {
        counter = 0;
    }

    function addRentals(
        string memory name,
        string memory city,
        int256 lat,
        int256 long,
        string memory unoDescription,
        string memory dosDescription,
        string memory imgUrl,
        uint256 maxGuests,
        uint256 pricePerDay,
        string[] memory datesBooked
    ) public onlyOwner {
        RentalInfo storage newRental = rentals[counter];
        newRental.name = name;
        newRental.city = city;
        newRental.lat = lat;
        newRental.long = long;
        newRental.unoDescription = unoDescription;
        newRental.dosDescription = dosDescription;
        newRental.imgUrl = imgUrl;
        newRental.maxGuests = maxGuests;
        newRental.pricePerDay = pricePerDay;
        newRental.datesBooked = datesBooked;
        newRental.id = counter;

        emit RentalCreated(counter, name, city, lat, long, unoDescription, dosDescription, imgUrl, maxGuests, pricePerDay, datesBooked);
        
        counter++;
    }

    function addDatesBooked(uint256 id, string[] memory newBookings) public payable rentalExists(id) {
        require(msg.value == rentals[id].pricePerDay * 1 ether * newBookings.length, "Incorrect payment amount");
        for (uint256 i = 0; i < newBookings.length; i++) {
            rentals[id].datesBooked.push(newBookings[i]);
        }
        emit NewDatesBooked(id, newBookings);
    }

    function getRental(uint256 id) public view rentalExists(id) returns (RentalInfo memory) {
        return rentals[id];
    }

    modifier rentalExists(uint256 id) {
        require(id < counter, "No such Rental");
        _;
    }

    function cancelBooking(uint256 id, string[] memory cancelDates) public rentalExists(id) {
        // Implement cancellation logic
    }

    function adjustPrice(uint256 id, uint256 newPricePerDay) public onlyOwner rentalExists(id) {
        rentals[id].pricePerDay = newPricePerDay;
    }

    function leaveReview(uint256 id, string memory review) public rentalExists(id) {
        // Implement review system
    }

function checkAvailability(uint256 id, uint256 startDate, uint256 endDate) public view rentalExists(id) {
    // Code logic for checking rental availability
}

function pauseContract() public onlyOwner {
    // Implement circuit breaker pattern
    // Placeholder for pausing the contract
}

function resumeContract() public onlyOwner {
    // Resume contract functionality
    // Placeholder for resuming the contract
}

}