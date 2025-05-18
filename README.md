# 🚚 DeliveryApp::TrustScore

A Move module on the Aptos blockchain that manages trust scores for delivery personnel. It tracks the number of deliveries, positive reviews, and dynamically updates the trust score based on customer feedback.

---

## 🧠 Features

- 📥 Register delivery agents
- ✅ Log completed deliveries
- ⭐ Update trust score based on customer reviews
- 📊 Track total deliveries and positive reviews

---

## ⚙️ Core Functions

### `register_delivery_person(account: &signer)`
Registers a new delivery agent with:
- `trust_score: 50`
- `total_deliveries: 0`
- `positive_reviews: 0`

Throws error if already registered.

---

### `complete_delivery(owner_addr: address, positive_review: bool)`
Updates the delivery stats and adjusts the trust score:
- +5 for positive review (max 100)
- -3 for negative review (min 0)

---

## 📄 Deployment Info

- **Module Name:** `TrustScore`
- **Contract Address:** `0xd6e3c83340251c8bececf345cf18cef78d21a0d1d1b0b138e9a9f7e084a81d1b`

🔗 [View on Aptos Explorer](https://explorer.aptoslabs.com/txn/0xd6e3c83340251c8bececf345cf18cef78d21a0d1d1b0b138e9a9f7e084a81d1b?network=devnet)

---

## 📸 Deployment Proof

![image](https://github.com/user-attachments/assets/6ad90c56-d7aa-40c5-aada-b9f661416d29)


_This image shows the successful transaction confirming deployment on Aptos Devnet._

---

## 🚀 Example Usage

```move
register_delivery_person(&signer);
complete_delivery(@addr, true);  // Positive review
complete_delivery(@addr, false); // Negative review
