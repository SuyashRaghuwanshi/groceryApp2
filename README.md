# 🛒 GroceryApp

A full-stack grocery shopping application built with **Flutter** (frontend) and **Node.js/Express** (backend), featuring user authentication, product catalog management, shopping cart, order processing, and integrated payment via Stripe.

---

## 📋 Table of Contents

- [Features](#-features)
- [Tech Stack](#-tech-stack)
- [Project Structure](#-project-structure)
- [Prerequisites](#-prerequisites)
- [Installation](#-installation)
- [Configuration](#-configuration)
- [Running the Application](#-running-the-application)
- [API Documentation](#-api-documentation)
- [Screenshots](#-screenshots)
- [Contributing](#-contributing)
- [License](#-license)

---

## ✨ Features

### User Features
- 🔐 **User Authentication** - Secure registration and login with JWT tokens
- 📱 **Product Browsing** - Browse products by categories with image carousels
- 🔍 **Product Details** - View detailed product information including pricing and descriptions
- 🛍️ **Shopping Cart** - Add, update, and remove items from cart
- 💳 **Secure Checkout** - Integrated Stripe payment processing
- 📦 **Order Management** - Track order history and status
- 🎨 **Responsive UI** - Beautiful Flutter interface with smooth animations

### Admin Features
- 📂 **Category Management** - Create, update, and delete product categories
- 🏷️ **Product Management** - Full CRUD operations for products
- 🖼️ **Image Upload** - Support for category and product images
- 📊 **Slider Management** - Manage promotional banners/sliders
- 🔗 **Related Products** - Link related products for better discovery

---

## 🛠️ Tech Stack

### Frontend
- **Framework**: Flutter 3.7.0
- **State Management**: Riverpod 2.6.1
- **Code Generation**: Freezed, JSON Serializable
- **HTTP Client**: http 1.3.0
- **Local Storage**: API Cache Manager, SQLite (sqflite_common_ffi)
- **UI Components**: Carousel Slider, Cupertino Icons

### Backend
- **Runtime**: Node.js
- **Framework**: Express 5.1.0
- **Database**: MongoDB (Mongoose 8.13.1)
- **Authentication**: JWT (jsonwebtoken 9.0.2)
- **Password Hashing**: bcrypt 5.1.1
- **File Upload**: Multer 1.4.5
- **Payment**: Stripe 18.0.0
- **API Documentation**: Swagger UI Express 5.0.1
- **CORS**: cors 2.8.5

---

## 📁 Project Structure

```
GroceryApp/
├── backend/                    # Node.js/Express backend
│   ├── config/                 # Configuration files
│   │   └── app.config.js      # MongoDB and Stripe config
│   ├── controllers/           # Route controllers
│   │   ├── cart.controller.js
│   │   ├── categories.controller.js
│   │   ├── order.controller.js
│   │   ├── products.controller.js
│   │   ├── slider.controller.js
│   │   └── users.controller.js
│   ├── middleware/            # Custom middleware
│   │   ├── auth.js           # JWT authentication
│   │   ├── error.js          # Error handling
│   │   └── *.upload.js       # File upload handlers
│   ├── models/               # Mongoose schemas
│   │   ├── user.model.js
│   │   ├── product.model.js
│   │   ├── category.model.js
│   │   ├── cart.model.js
│   │   └── order.model.js
│   ├── routes/               # API routes
│   ├── services/             # Business logic
│   ├── uploads/              # Uploaded files storage
│   ├── swagger.json          # API documentation
│   ├── index.js              # Server entry point
│   └── package.json
│
├── frontend/                  # Flutter mobile app
│   ├── lib/
│   │   ├── api/              # API client
│   │   ├── application/      # Application logic
│   │   ├── component/        # Reusable components
│   │   ├── models/           # Data models
│   │   ├── pages/            # App screens
│   │   │   ├── login_page.dart
│   │   │   ├── register_page.dart
│   │   │   ├── dashboard_page.dart
│   │   │   ├── home_page.dart
│   │   │   ├── products_page.dart
│   │   │   ├── product_details_page.dart
│   │   │   └── cart_page.dart
│   │   ├── providers/        # Riverpod providers
│   │   ├── utils/            # Utility functions
│   │   ├── widgets/          # Custom widgets
│   │   ├── config.dart       # App configuration
│   │   └── main.dart         # App entry point
│   ├── assets/               # Images and assets
│   ├── pubspec.yaml          # Flutter dependencies
│   └── README.md
│
└── package.json              # Root package file
```

---

## 📋 Prerequisites

Before you begin, ensure you have the following installed:

- **Node.js** (v14 or higher)
- **npm** or **yarn**
- **MongoDB** (local installation or MongoDB Atlas account)
- **Flutter SDK** (3.7.0 or higher)
- **Dart SDK** (comes with Flutter)
- **Android Studio** / **Xcode** (for mobile development)
- **Stripe Account** (for payment processing)

---

## 🚀 Installation

### 1. Clone the Repository

```bash
git clone <repository-url>
cd GroceryApp
```

### 2. Backend Setup

```bash
cd backend
npm install
```

### 3. Frontend Setup

```bash
cd frontend
flutter pub get
```

Generate model files (if needed):
```bash
flutter pub run build_runner build --delete-conflicting-outputs
```

---

## ⚙️ Configuration

### Backend Configuration

1. **MongoDB Configuration**

Edit `backend/config/app.config.js`:

```javascript
const MONGO_DB_CONFIG = {
    DB: "mongodb://localhost/groceryApp",  // Update with your MongoDB URI
    PAGE_SIZE: 10,
};
```

For MongoDB Atlas, use:
```javascript
DB: "mongodb+srv://<username>:<password>@cluster.mongodb.net/groceryApp"
```

2. **Stripe Configuration**

Update your Stripe secret key in `backend/config/app.config.js`:

```javascript
const STRIPE_CONFIG = {
    STRIPE_KEY: "sk_test_YOUR_STRIPE_SECRET_KEY",  // Replace with your key
    CURRENCY: "inr",
};
```

3. **JWT Secret**

Update the JWT secret in `backend/middleware/auth.js`:

```javascript
const TOKEN_KEY = "YOUR_SECURE_RANDOM_KEY";  // Use a strong secret key
```

### Frontend Configuration

Edit `frontend/lib/config.dart` to point to your backend API:

```dart
// Update the base URL to match your backend server
const String API_BASE_URL = "http://localhost:3000/api";
```

For Android emulator, use:
```dart
const String API_BASE_URL = "http://10.0.2.2:3000/api";
```

For iOS simulator, use:
```dart
const String API_BASE_URL = "http://localhost:3000/api";
```

For physical devices, use your computer's local IP:
```dart
const String API_BASE_URL = "http://192.168.x.x:3000/api";
```

---

## 🏃 Running the Application

### Start MongoDB

Ensure MongoDB is running:

```bash
# For local MongoDB
mongod

# Or use MongoDB Atlas (cloud)
```

### Start Backend Server

```bash
cd backend
node index.js
# or with nodemon for auto-reload
npx nodemon index.js
```

The server will start on `http://localhost:3000`

### Start Flutter App

```bash
cd frontend
flutter run
```

Or run on specific device:
```bash
flutter run -d chrome        # Web
flutter run -d android       # Android
flutter run -d ios           # iOS
```

---

## 📚 API Documentation

The API is documented using Swagger. Once the backend is running, access the interactive API documentation at:

**Swagger UI**: `http://localhost:3000/api-docs`

### Key API Endpoints

#### Authentication
- `POST /api/register` - Register new user
- `POST /api/login` - User login
- `POST /api/logout` - User logout

#### Products
- `GET /api/product` - Get all products
- `GET /api/product/:id` - Get product by ID
- `POST /api/product` - Create product (requires auth)
- `PUT /api/product/:id` - Update product (requires auth)
- `DELETE /api/product/:id` - Delete product (requires auth)

#### Categories
- `GET /api/category` - Get all categories
- `GET /api/category/:id` - Get category by ID
- `POST /api/category` - Create category (requires auth)
- `PUT /api/category/:id` - Update category (requires auth)
- `DELETE /api/category/:id` - Delete category (requires auth)

#### Cart
- `GET /api/cart` - Get user cart (requires auth)
- `POST /api/cart` - Add to cart (requires auth)
- `PUT /api/cart/:id` - Update cart item (requires auth)
- `DELETE /api/cart/:id` - Remove from cart (requires auth)

#### Orders
- `GET /api/order` - Get user orders (requires auth)
- `POST /api/order` - Create order (requires auth)

#### Sliders
- `GET /api/slider` - Get all sliders
- `POST /api/slider` - Create slider (requires auth)

---

## 🔐 Authentication

The application uses **JWT (JSON Web Tokens)** for authentication:

1. User registers or logs in
2. Backend generates a JWT token (expires in 1 hour)
3. Frontend stores token in local cache
4. Token is sent in `Authorization` header for protected routes:
   ```
   Authorization: Bearer <token>
   ```
5. Backend middleware validates token before processing requests

---

## 💾 Database Schema

### User
- fullName (String)
- email (String, unique)
- password (String, hashed)
- stripeCustomerId (String)

### Product
- productName (String, unique)
- category (ObjectId ref Category)
- productShortDescription (String)
- productDescription (String)
- productPrice (Number)
- productSalePrice (Number)
- productImage (String)
- productSKU (String)
- productType (String)
- stockStatus (String)
- relatedProducts (Array of ObjectId)

### Category
- categoryName (String)
- categoryDescription (String)
- categoryImage (String)

### Cart
- userId (ObjectId ref User)
- productId (ObjectId ref Product)
- quantity (Number)

### Order
- userId (ObjectId ref User)
- products (Array)
- totalAmount (Number)
- status (String)
- paymentId (String)

---

## 🎨 Screenshots

<!-- Add screenshots of your application here -->

---

## 🤝 Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

## 📝 License

This project is licensed under the ISC License.

---

## 👨‍💻 Developer

**Suyash Raghuwanshi**

---

## 🐛 Known Issues

- CORS is currently configured for `http://localhost:5000` - update as needed
- Stripe test mode is enabled - configure production keys for live deployment
- Token blacklisting is commented out in auth middleware

---

## 🔮 Future Enhancements

- [ ] Add product search functionality
- [ ] Implement product reviews and ratings
- [ ] Add wishlist feature
- [ ] Implement push notifications
- [ ] Add admin dashboard
- [ ] Multi-language support
- [ ] Dark mode theme
- [ ] Order tracking with real-time updates
- [ ] Product recommendations based on purchase history

---

## 📞 Support

For support, email [your-email@example.com] or open an issue in the repository.

---

**Happy Shopping! 🛍️**
