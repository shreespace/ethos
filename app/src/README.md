## TripQ: Decentralized Hotel Booking Platform

### How to Run
1. Clone the repository.
2. Install dependencies for frontend and backend.
   ```bash
   cd frontend
   npm install
   cd backend
   npm install
   ```
3. Run the local blockchain (Ganache or Hardhat).
   ```bash
   npx hardhat node
   ```
4. Deploy smart contracts.
   ```bash
   npx hardhat run scripts/deploy.js
   ```
5. Start backend server.
   ```bash
   cd backend
   node server.js
   ```
6. Start frontend.
   ```bash
   cd frontend
   npm start
   ```
