const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("AIRBNB Contract", function () {
    let airbnb;
    let owner, renter1, renter2;

    beforeEach(async function () {
        [owner, renter1, renter2] = await ethers.getSigners();

        const AIRBNB = await ethers.getContractFactory("Airbnb", owner);
        airbnb = await AIRBNB.deploy();
        await airbnb.deployed();
    });

    describe("Ownership", function () {
        it("should assign the deployer as the owner", async function () {
            expect(await airbnb.owner()).to.equal(owner.address);
        });
    });

    describe("Manage Rentals", function () {
        it("should allow the owner to add a rental", async function () {
            // Replace with actual parameters for your addRentals function
            await airbnb.addRentals("Rental1", "City1", 0, 0, "Desc1", "Desc2", "imgUrl", 4, ethers.utils.parseEther("1.0"), []);
            // Add assertions to verify the rental was added
            // For example, check the counter or the contents of the rental
        });

        it("should not allow non-owner to add a rental", async function () {
            // Attempt to add a rental from a non-owner account
            await expect(airbnb.connect(renter1).addRentals("Rental2", "City2", 0, 0, "Desc1", "Desc2", "imgUrl", 4, ethers.utils.parseEther("1.0"), [])).to.be.revertedWith("Only owner of smart contract can put up rentals");
        });
    });

    describe("Booking and Cancellation", function () {
        beforeEach(async function () {
            // Add a rental before each booking test
            await airbnb.addRentals("Rental1", "City1", 0, 0, "Desc1", "Desc2", "imgUrl", 4, ethers.utils.parseEther("1.0"), []);
        });

        it("should allow a user to book a rental", async function () {
            // Implement booking test
            // You need to replace the parameters and value with appropriate ones
            await expect(airbnb.connect(renter1).addDatesBooked(0, ["2024-07-01"], { value: ethers.utils.parseEther("1.0") })).to.emit(airbnb, "NewDatesBooked");
            // Add assertions to check if the booking was successful
        });

        it("should not allow booking on already booked dates", async function () {
            // First booking
            await airbnb.connect(renter1).addDatesBooked(0, ["2024-07-01"], { value: ethers.utils.parseEther("1.0") });

            // Attempt to book the same date
            await expect(airbnb.connect(renter2).addDatesBooked(0, ["2024-07-01"], { value: ethers.utils.parseEther("1.0") })).to.be.reverted;
            // Check the specific revert message based on your contract logic
        });
    });

    // ... Additional describe blocks for other functionalities like cancellation, reviews, etc.
});
