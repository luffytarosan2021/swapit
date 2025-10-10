# SWAPIT - Futuristic Barter Marketplace

A modern, responsive marketplace application built with HTML/CSS/JavaScript frontend and Spring Boot backend.

## Features

### Frontend
- ✅ Responsive design with mobile-first approach
- ✅ Modern futuristic UI with neon colors and animations
- ✅ Mobile navigation with hamburger menu
- ✅ Interactive card hover effects
- ✅ Cross-browser compatibility

### Backend (Spring Boot)
- ✅ RESTful API with Spring Boot 3.2.0
- ✅ JWT Authentication & Authorization
- ✅ PostgreSQL Database Integration
- ✅ User Management System
- ✅ Item/Product Management
- ✅ Transaction System
- ✅ Points & Trust Score System
- ✅ Leaderboard functionality
- ✅ CORS Configuration
- ✅ Security with Spring Security

## Tech Stack

### Frontend
- HTML5, CSS3, JavaScript
- Responsive Grid Layout
- CSS Animations & Transitions
- Mobile-First Design

### Backend
- Java 17
- Spring Boot 3.2.0
- Spring Security
- Spring JDBC
- MySQL 8.0
- JWT Authentication
- Maven

## Setup Instructions

### Prerequisites
- Java 17 or higher
- Maven 3.6+
- MySQL 8.0+
- Git

### Database Setup

#### Option 1: Automated Setup (Recommended)
1. Install MySQL 8.0+
2. Start MySQL service:
   ```bash
   # On macOS
   brew services start mysql
   
   # On Ubuntu/Debian
   sudo systemctl start mysql
   
   # On Windows
   # Start MySQL service from Services
   ```
3. Run the setup script:
   ```bash
   cd "/Users/diya/Desktop Files/prototype_swapit"
   ./setup-database.sh
   ```

#### Option 2: Manual Setup
1. Install MySQL 8.0+
2. Start MySQL service
3. Connect to MySQL as root:
   ```bash
   mysql -u root -p
   ```
4. Run the SQL script:
   ```bash
   mysql -u root -p < database/setup.sql
   ```

### Backend Setup
1. Navigate to the project directory:
   ```bash
   cd /Users/diya/Desktop\ Files/prototype_swapit
   ```

2. Database configuration is already set in `src/main/resources/application.yml`:
   ```yaml
   spring:
     datasource:
       url: jdbc:mysql://localhost:3306/swapit?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true
       username: swapit
       password: swapit123
   ```

3. Build and run the application:
   ```bash
   mvn clean install
   mvn spring-boot:run
   ```

4. The backend will be available at `http://localhost:8080/api`

### Frontend Setup
1. Open `index.html` in your web browser
2. The frontend is already configured to work with the backend

## API Endpoints

### Authentication
- `POST /api/auth/register` - Register new user
- `POST /api/auth/login` - User login
- `GET /api/auth/me` - Get current user
- `POST /api/auth/logout` - User logout

### Items
- `GET /api/items` - Get all items (with filters)
- `GET /api/items/{id}` - Get item by ID
- `POST /api/items` - Create new item (Auth required)
- `PUT /api/items/{id}` - Update item (Auth required)
- `DELETE /api/items/{id}` - Delete item (Auth required)

### Users
- `GET /api/users` - Get all users
- `GET /api/users/{id}` - Get user by ID
- `GET /api/users/leaderboard` - Get leaderboard
- `GET /api/users/trusted` - Get trusted users

### Health Check
- `GET /api/health` - Application health status

## Project Structure

```
prototype_swapit/
├── index.html                 # Frontend application
├── pom.xml                   # Maven configuration
├── src/main/java/com/swapit/
│   ├── SwapitApplication.java
│   ├── config/               # Configuration classes
│   ├── controller/           # REST controllers
│   ├── dto/                 # Data Transfer Objects
│   ├── entity/              # JPA entities
│   ├── repository/          # Data repositories
│   └── service/            # Business logic services
└── src/main/resources/
    └── application.yml       # Application configuration
```

## Development

### Running in Development Mode
```bash
mvn spring-boot:run -Dspring-boot.run.profiles=dev
```

### Building for Production
```bash
mvn clean package
java -jar target/swapit-backend-1.0.0.jar
```

## Features in Detail

### Responsive Design
- Mobile-first approach with breakpoints at 480px, 768px, and 1024px
- Collapsible navigation menu for mobile devices
- Optimized card layouts for different screen sizes
- Touch-friendly interface elements

### Backend Architecture
- Clean architecture with separation of concerns
- JWT-based authentication
- Role-based access control (USER, ADMIN, MODERATOR)
- Comprehensive error handling
- Direct JDBC access for optimal performance
- Database relationships with proper foreign keys

### Security Features
- Password encryption with BCrypt
- JWT token authentication
- CORS configuration
- Rate limiting
- Input validation

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

MIT License - see LICENSE file for details
