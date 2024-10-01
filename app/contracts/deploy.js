async function main() {
    const HotelBooking = await ethers.getContractFactory("HotelBooking");
    const hotelBooking = await HotelBooking.deploy();
    await hotelBooking.deployed();
    console.log("HotelBooking deployed to:", hotelBooking.address);
  }
  
  main().catch((error) => {
    console.error(error);
    process.exitCode = 1;
  });