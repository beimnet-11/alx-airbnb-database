## 1. Entities and Attributes

### **User**
- user_id (PK)
- first_name
- last_name
- email
- phone_number
- date_joined

### **Property**
- property_id (PK)
- host_id (FK → User.user_id)
- title
- description
- address
- city
- country
- price_per_night
- created_at

### **Booking**
- booking_id (PK)
- user_id (FK → User.user_id)
- property_id (FK → Property.property_id)
- start_date
- end_date
- total_price
- status

### **Review**
- review_id (PK)
- booking_id (FK → Booking.booking_id)
- user_id (FK → User.user_id)
- rating
- comment
- created_at

### **Payment**
- payment_id (PK)
- booking_id (FK → Booking.booking_id)
- amount
- payment_method
- payment_date
- status

## 2. Relationships

| Relationship | Description |
|---------------|-------------|
| User → Property | One user (host) can list many properties. (1:N) |
| User → Booking | One user can make many bookings. (1:N) |
| Property → Booking | A property can have many bookings. (1:N) |
| Booking → Review | A booking can have one review. (1:1) |
| Booking → Payment | A booking can have one payment record. (1:1) |
<img width="1487" height="880" alt="Screenshot from 2025-10-26 22-13-13" src="https://github.com/user-attachments/assets/c60a614b-6f59-4b16-8eda-cc794fa38580" />


