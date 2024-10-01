const express = require('express');
const bodyParser = require('body-parser');
const Web3 = require('web3');
const contract = require('./contracts/HotelBooking.json');

const app = express();
app.use(bodyParser.json());

const web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));

const networkId = await web3.eth.net.getId();
const HotelBooking = new web3.eth.Contract(
  contract.abi,
  contract.networks[networkId].address
);

app.post('/book', async (req, res) => {
  const { hotelId, userAddress } = req.body;
  await HotelBooking.methods.bookHotel(hotelId).send({ from: userAddress });
  res.send('Booking confirmed');
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});
