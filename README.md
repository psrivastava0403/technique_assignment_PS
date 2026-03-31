# 🚀 Payment Processing System (Rails + Sidekiq)

## 📌 Overview

This project implements a **robust payment processing system** using Ruby on Rails, inspired by real-world systems like Stripe.

It handles:

* Idempotent payment requests
* Background job processing
* Retry mechanisms
* Order lifecycle management
* Concurrency safety

---

## 🧠 Key Features

### ✅ Idempotency

* Prevents duplicate payments using `Idempotency-Key`
* Same request → same response (no duplicate DB records)

### ⚡ Background Processing

* Uses Sidekiq + Redis
* Payment processing happens asynchronously

### 🔁 Retry Mechanism

* Automatic retries on failure
* Simulates real-world payment gateway failures

### 🧵 Concurrency Handling

* Safe against duplicate requests
* Uses DB constraints and logic safeguards

### ❌ Order Cancellation Handling

* Prevents payments on cancelled orders

---

## 🏗️ Tech Stack

* Ruby on Rails 7
* PostgreSQL
* Sidekiq
* Redis

---

## 📂 Project Structure

app/
├── controllers/
├── models/
├── services/
│   └── payment_service.rb
├── jobs/
│   └── process_payment_job.rb

---

## ⚙️ Setup Instructions

### 1. Clone the repo

```bash
git clone <your-repo-url>
cd technique_rails_project
```

---

### 2. Install dependencies

```bash
bundle install
```

---

### 3. Setup database

```bash
rails db:create db:migrate
```

---

### 4. Start Redis

```bash
redis-server
```

---

### 5. Start Sidekiq

```bash
bundle exec sidekiq
```

---

### 6. Start Rails server

```bash
rails s
```

---

## 🔗 API Endpoints

### 📦 Create Order

```bash
POST /orders
```

#### Request:

```json
{
  "external_id": "order_1",
  "payload": {
    "amount": 100
  }
}
```

---

### 💳 Create Payment

```bash
POST /orders/:order_id/payments
```

#### Headers:

```
Idempotency-Key: abc123
```

#### Request:

```json
{
  "details": {
    "amount": 100
  }
}
```

---

### ❌ Cancel Order

```bash
DELETE /orders/:id
```

---

## 🧪 Testing Scenarios

### 🔁 Idempotency Test

* Send same request twice with same key
* Should return same response

### ⚡ Async Processing

* Payment status initially "pending"
* Updated via Sidekiq job

### 🔄 Retry Logic

* Random failures simulated using `rand < 0.7`
* Retries automatically triggered

### ❌ Edge Cases

* Duplicate payment prevention
* Payment on cancelled order rejected

---

## 🧠 Design Decisions

* Used Service Object (`PaymentService`) to keep controllers thin
* Used background jobs for scalability
* Used idempotency keys to ensure reliability
* Followed RESTful API principles

---

## 🎯 Future Improvements

* Add authentication
* Add rate limiting
* Add webhook support
* Add payment gateway integration

---

## 🧪 Test Cases / Scenarios

### 1. Create Order

* Valid request → Order created
* Duplicate `external_id` → Rejected

---

### 2. Create Payment

* Valid request → Payment created (status: pending)
* Background job processes payment → status updated

---

### 3. Idempotency Test

* Same `Idempotency-Key` → No duplicate payment
* Response remains same

---

### 4. Duplicate Request Handling

* Multiple requests with same key → Single DB entry

---

### 5. Retry Mechanism

* Simulated failure → Retry triggered
* Retry count increases

---

### 6. Order Cancellation

* Cancel order → status updated to cancelled
* Payment attempt after cancel → rejected

---

### 7. Edge Cases

* Missing Idempotency-Key → error
* Invalid order → error
* Concurrent requests → safe handling

---

## 👨‍💻 Author

Prashant Srivastava

---

## ⭐ Summary

This project demonstrates:

* Production-level architecture
* Clean code practices
* Real-world payment system design

---
