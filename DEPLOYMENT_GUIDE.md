# 🚀 Hostinger Deployment Guide

## 📋 **Prerequisites**

1. **Hostinger Account** with hosting plan
2. **Domain** registered
3. **MongoDB Atlas** account (free tier available)
4. **Git** installed on your computer

---

## 🗄️ **Step 1: Database Setup (MongoDB Atlas)**

### 1.1 Create MongoDB Atlas Account
1. Go to [MongoDB Atlas](https://www.mongodb.com/atlas)
2. Sign up for free account
3. Create a new cluster (free tier M0)

### 1.2 Database Configuration
1. **Create Database User:**
   - Go to Database Access
   - Add New Database User
   - Username: `glinthive_admin`
   - Password: Generate secure password
   - Database User Privileges: Read and write to any database

2. **Network Access:**
   - Go to Network Access
   - Add IP Address: `0.0.0.0/0` (Allow access from anywhere)
   - Or add your server IP

3. **Get Connection String:**
   - Go to Clusters
   - Click "Connect"
   - Choose "Connect your application"
   - Copy connection string
   - Replace `<password>` with your database user password

---

## 🌐 **Step 2: Hostinger Setup**

### 2.1 Upload Files to Hostinger

#### **Option A: File Manager (Recommended for beginners)**

1. **Login to Hostinger Control Panel**
2. **Go to File Manager**
3. **Navigate to `public_html` folder**
4. **Upload your project files:**

```
public_html/
├── backend/          # Backend files
│   ├── server.js
│   ├── package.json
│   ├── node_modules/
│   └── .env
├── glinthive/        # Frontend build files
│   └── dist/         # Built React app
└── index.html        # Main entry point
```

#### **Option B: Git Deployment (Advanced)**

1. **SSH into your server**
2. **Clone your repository:**
   ```bash
   git clone https://github.com/yourusername/glinthive.git
   cd glinthive
   ```

### 2.2 Backend Setup

1. **Create `.env` file in backend folder:**
   ```env
   NODE_ENV=production
   PORT=5000
   MONGODB_URI=mongodb+srv://glinthive_admin:yourpassword@cluster.mongodb.net/glinthive?retryWrites=true&w=majority
   JWT_SECRET=your-super-secure-jwt-secret-key-here
   CLIENT_ORIGIN=https://yourdomain.com
   ```

2. **Install dependencies:**
   ```bash
   cd backend
   npm install --production
   ```

3. **Create admin user:**
   ```bash
   npm run setup-admin
   ```

4. **Start backend:**
   ```bash
   npm run start:prod
   ```

### 2.3 Frontend Build

1. **Build React app:**
   ```bash
   cd glinthive
   npm install
   npm run build:prod
   ```

2. **Upload `dist` folder contents to `public_html`**

---

## ⚙️ **Step 3: Server Configuration**

### 3.1 Node.js Setup (if not available)

1. **Install Node.js on Hostinger:**
   - Go to Advanced → Node.js
   - Enable Node.js
   - Set Node.js version (18.x recommended)

2. **Set Application Root:**
   - Application Root: `/backend`
   - Application URL: `yourdomain.com`

### 3.2 Process Manager (PM2)

1. **Install PM2:**
   ```bash
   npm install -g pm2
   ```

2. **Create PM2 config:**
   ```javascript
   // ecosystem.config.js
   module.exports = {
     apps: [{
       name: 'glinthive-backend',
       script: 'server.js',
       cwd: '/path/to/backend',
       env: {
         NODE_ENV: 'production',
         PORT: 5000
       }
     }]
   }
   ```

3. **Start with PM2:**
   ```bash
   pm2 start ecosystem.config.js
   pm2 save
   pm2 startup
   ```

---

## 🔧 **Step 4: Domain Configuration**

### 4.1 DNS Settings

1. **Point domain to Hostinger:**
   - A Record: `@` → Hostinger IP
   - CNAME: `www` → `yourdomain.com`

### 4.2 SSL Certificate

1. **Enable SSL in Hostinger:**
   - Go to SSL
   - Enable "Let's Encrypt" (free)
   - Force HTTPS redirect

---

## 📁 **Step 5: File Structure on Server**

```
public_html/
├── index.html                    # Main entry point
├── assets/                       # Built React assets
│   ├── index-[hash].js
│   ├── index-[hash].css
│   └── ...
├── backend/                      # Backend API
│   ├── server.js
│   ├── package.json
│   ├── .env
│   └── node_modules/
└── admin/                        # Admin panel
    └── login.html               # Admin login page
```

---

## 🔐 **Step 6: Security Configuration**

### 6.1 Environment Variables

**Backend `.env`:**
```env
NODE_ENV=production
PORT=5000
MONGODB_URI=mongodb+srv://username:password@cluster.mongodb.net/glinthive
JWT_SECRET=your-very-secure-jwt-secret-key-minimum-32-characters
CLIENT_ORIGIN=https://yourdomain.com
```

**Frontend `.env.production`:**
```env
VITE_API_BASE_URL=https://yourdomain.com/api
```

### 6.2 Security Headers

Add to your server.js:
```javascript
app.use((req, res, next) => {
  res.setHeader('X-Content-Type-Options', 'nosniff');
  res.setHeader('X-Frame-Options', 'DENY');
  res.setHeader('X-XSS-Protection', '1; mode=block');
  next();
});
```

---

## 🧪 **Step 7: Testing**

### 7.1 Test Your Deployment

1. **Frontend:** `https://yourdomain.com`
2. **API Health:** `https://yourdomain.com/api/health`
3. **Admin Panel:** `https://yourdomain.com/admin/login`

### 7.2 Test Forms

1. **Contact Form:** Submit test data
2. **Advice Form:** Submit test data
3. **Admin Login:** Login with admin credentials

---

## 📊 **Step 8: Monitoring**

### 8.1 Logs

```bash
# View PM2 logs
pm2 logs glinthive-backend

# View real-time logs
pm2 logs glinthive-backend --lines 100
```

### 8.2 Performance

```bash
# Monitor PM2 processes
pm2 monit

# Restart if needed
pm2 restart glinthive-backend
```

---

## 🚨 **Troubleshooting**

### Common Issues:

1. **CORS Errors:**
   - Check `CLIENT_ORIGIN` in backend `.env`
   - Ensure frontend URL matches

2. **Database Connection:**
   - Verify MongoDB Atlas connection string
   - Check network access settings

3. **Build Errors:**
   - Clear node_modules and reinstall
   - Check Node.js version compatibility

4. **Admin Login Issues:**
   - Run `npm run setup-admin` again
   - Check JWT_SECRET is set

---

## 📞 **Support**

If you encounter issues:

1. Check server logs: `pm2 logs`
2. Verify environment variables
3. Test API endpoints individually
4. Check browser console for errors

---

## 🎉 **Success!**

Once deployed, your Glint Hive website will be live with:
- ✅ Professional website
- ✅ Contact & Advice forms
- ✅ Admin panel for lead management
- ✅ Secure authentication
- ✅ Mobile responsive design

**Your website URL:** `https://yourdomain.com`
**Admin Panel:** `https://yourdomain.com/admin/login`
