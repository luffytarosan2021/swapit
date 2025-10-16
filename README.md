# SWAPIT - Futuristic Barter Marketplace

A modern, full-stack barter marketplace built with Spring Boot and PostgreSQL, featuring a beautiful web interface for trading items using a points-based system.

## 🚀 Features

- **User Authentication**: Secure registration and login with JWT tokens
- **Points-Based Trading**: Trade items using a points system instead of money
- **Trust System**: User trust scores and verification system
- **Item Management**: List, browse, and manage items for trade
- **Transaction Tracking**: Complete transaction history and management
- **Modern UI**: Beautiful, responsive web interface
- **RESTful API**: Well-structured backend API

## 🛠️ Tech Stack

### Backend
- **Java 23**
- **Spring Boot 3.2.0**
- **Spring Security** with JWT authentication
- **Spring Data JPA** for database operations
- **PostgreSQL** database
- **Maven** for dependency management

### Frontend
- **HTML5** with modern CSS
- **Vanilla JavaScript** for API interactions
- **Responsive Design** for all devices

## 📋 Prerequisites

Before running the application, make sure you have:

1. **Java 23** or higher installed
2. **PostgreSQL** installed and running
3. **Maven 3.6+** (or use the included Maven wrapper)
4. **Git** for cloning the repository

## 🚀 Quick Start

### 1. Clone the Repository
```bash
git clone <repository-url>
cd prototype_swapit
```

### 2. Set Up PostgreSQL Database
Run the automated setup script:
```bash
./setup-postgresql.sh
```

Or manually set up the database:
```sql
CREATE DATABASE swapit;
CREATE USER swapit WITH PASSWORD 'swapit123';
GRANT ALL PRIVILEGES ON DATABASE swapit TO swapit;
```

### 3. Start the Application
```bash
./mvnw spring-boot:run
```

### 4. Access the Application
Open your browser and navigate to:
- **Frontend**: http://localhost:8080
- **API Base**: http://localhost:8080/api

## 📱 Usage

### Registration
1. Open http://localhost:8080
2. Click "Register here" to create a new account
3. Fill in your details (username, email, password, name)
4. You'll receive 100 starting points and a trust score of 100

### Login
1. Use your username and password to log in
2. You'll be redirected to your dashboard
3. View your points, trust score, and manage your items

### Dashboard Features
- **View Stats**: See your total points, trust score, and listed items
- **Browse Items**: Discover items available for trade
- **List Items**: Add your own items to the marketplace
- **Manage Items**: View and manage your listed items
- **View Transactions**: Track your trading history

## 🔧 Configuration

### Database Configuration
The application is configured to connect to PostgreSQL with these default settings:
- **Host**: localhost
- **Port**: 5432
- **Database**: swapit
- **Username**: swapit
- **Password**: swapit123

To change these settings, modify `src/main/resources/application.yml`:

```yaml
spring:
  datasource:
    url: jdbc:postgresql://localhost:5432/swapit
    username: your_username
    password: your_password
    driver-class-name: org.postgresql.Driver
```

### JWT Configuration
JWT settings can be modified in `application.yml`:
```yaml
jwt:
  secret: your-secret-key
  expiration: 604800 # 7 days in seconds
```

## 📊 API Endpoints

### Authentication
- `POST /api/auth/register` - Register a new user
- `POST /api/auth/login` - Login user
- `POST /api/auth/logout` - Logout user
- `GET /api/auth/me` - Get current user info

### Users
- `GET /api/users` - Get all users
- `GET /api/users/{id}` - Get user by ID
- `GET /api/users/username/{username}` - Get user by username
- `PUT /api/users/{id}` - Update user
- `DELETE /api/users/{id}` - Delete user (admin only)
- `GET /api/users/leaderboard` - Get leaderboard
- `GET /api/users/trusted` - Get trusted users

### Items
- `GET /api/items` - Get all items (with filters)
- `GET /api/items/{id}` - Get item by ID
- `POST /api/items` - Create new item
- `PUT /api/items/{id}` - Update item
- `DELETE /api/items/{id}` - Delete item
- `GET /api/items/user/{userId}` - Get items by user
- `GET /api/items/categories` - Get available categories
- `GET /api/items/conditions` - Get available conditions

## 🗄️ Database Schema

### Users Table
- `id` - Primary key (BIGSERIAL)
- `username` - Unique username (VARCHAR)
- `email` - Unique email (VARCHAR)
- `password` - Encrypted password (VARCHAR)
- `first_name`, `last_name` - User names (VARCHAR)
- `bio` - User biography (TEXT)
- `profile_image_url` - Profile picture URL (VARCHAR)
- `points` - User's points balance (INTEGER)
- `trust_score` - Trust score (0-100) (INTEGER)
- `is_verified` - Verification status (BOOLEAN)
- `is_active` - Account status (BOOLEAN)
- `role` - User role (USER, ADMIN, MODERATOR) (VARCHAR)
- `created_at`, `updated_at` - Timestamps (TIMESTAMP)

### Items Table
- `id` - Primary key (BIGSERIAL)
- `title` - Item title (VARCHAR)
- `description` - Item description (TEXT)
- `category` - Item category (VARCHAR)
- `condition` - Item condition (VARCHAR)
- `status` - Item status (AVAILABLE, PENDING, SOLD, REMOVED) (VARCHAR)
- `points_value` - Points required for trade (INTEGER)
- `image_url` - Item image URL (VARCHAR)
- `owner_id` - Foreign key to users table (BIGINT)
- `created_at`, `updated_at` - Timestamps (TIMESTAMP)

### Carts Table
- `id` - Primary key (BIGSERIAL)
- `user_id` - Foreign key to users table (BIGINT)
- `item_id` - Foreign key to items table (BIGINT)
- `quantity` - Quantity of items (INTEGER)
- `total_points` - Total points for cart item (INTEGER)
- `added_at` - Timestamp when added (TIMESTAMP)

### Transactions Table
- `id` - Primary key (BIGSERIAL)
- `buyer_id` - Foreign key to users table (BIGINT)
- `seller_id` - Foreign key to users table (BIGINT)
- `item_id` - Foreign key to items table (BIGINT)
- `quantity` - Quantity traded (INTEGER)
- `total_points` - Total points transferred (INTEGER)
- `status` - Transaction status (VARCHAR)
- `transaction_date` - When transaction occurred (TIMESTAMP)
- `completed_at` - When transaction completed (TIMESTAMP)

## 🔒 Security Features

- **JWT Authentication**: Secure token-based authentication
- **Password Encryption**: BCrypt password hashing
- **CORS Configuration**: Cross-origin resource sharing setup
- **Role-Based Access**: Different access levels for users, admins, and moderators
- **Input Validation**: Server-side validation for all inputs

## 🧪 Testing

### Manual Testing
1. Register a new user
2. Login with the new user
3. Try to access protected endpoints
4. Test item creation and management
5. Test user profile updates

### API Testing
You can use tools like Postman or curl to test the API endpoints:

```bash
# Register a new user
curl -X POST http://localhost:8080/api/auth/register \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "email": "test@example.com",
    "password": "password123",
    "firstName": "Test",
    "lastName": "User"
  }'

# Login
curl -X POST http://localhost:8080/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{
    "username": "testuser",
    "password": "password123"
  }'
```

## 🐛 Troubleshooting

### Common Issues

1. **Database Connection Error**
   - Ensure PostgreSQL is running
   - Check database credentials in `application.yml`
   - Verify database and user exist

2. **Port Already in Use**
   - Change the port in `application.yml`:
   ```yaml
   server:
     port: 8081
   ```

3. **JWT Token Issues**
   - Check JWT secret configuration
   - Ensure tokens are being sent in Authorization header

4. **CORS Issues**
   - Verify CORS configuration in `SecurityConfig.java`
   - Check allowed origins and methods

### Debug Endpoints
Access these endpoints to view raw database data:
- `GET /api/debug/users-basic` - Basic user info
- `GET /api/debug/users` - Full user data
- `GET /api/debug/items` - All items data
- `GET /api/debug/carts` - Cart data
- `GET /api/debug/transactions` - Transaction data

### Logs
Check the application logs for detailed error information:
```bash
tail -f logs/swapit.log
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- Spring Boot team for the excellent framework
- MySQL team for the robust database
- All contributors and testers

## 📞 Support

If you encounter any issues or have questions:
1. Check the troubleshooting section
2. Review the logs
3. Create an issue in the repository
4. Contact the development team

---

**Happy Trading with SWAPIT! 🎉**
