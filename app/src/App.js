import React, { useState, useEffect } from 'react';
import Web3 from 'web3';
import HotelBooking from './contracts/HotelBooking.json'; // Smart contract ABI

const App = () => {
  const [account, setAccount] = useState('');
  const [hotels, setHotels] = useState([]);

  useEffect(() => {
    loadBlockchainData();
  }, []);

  const loadBlockchainData = async () => {
    const web3 = new Web3(Web3.givenProvider || "http://localhost:8545");
    const accounts = await web3.eth.getAccounts();
    setAccount(accounts[0]);
    
    const networkId = await web3.eth.net.getId();
    const deployedNetwork = HotelBooking.networks[networkId];
    const contract = new web3.eth.Contract(
      HotelBooking.abi,
      deployedNetwork && deployedNetwork.address
    );

    const hotelList = await contract.methods.getHotels().call();
    setHotels(hotelList);
  };

  return (
    <div>
      <h1>Welcome to TripQ</h1>
      <p>Your account: {account}</p>
      <div>
        <h2>Available Hotels</h2>
        <ul>
          {hotels.map((hotel, index) => (
            <li key={index}>{hotel.name}</li>
          ))}
        </ul>
      </div>
    </div>
  );
};

export default App;
