# ✅ Hostinger Deployment Checklist

## 📋 **Pre-Deployment Checklist**

### 🗄️ **Database Setup**
- [ ] MongoDB Atlas account created
- [ ] Database cluster created (free tier M0)
- [ ] Database user created with read/write permissions
- [ ] Network access configured (0.0.0.0/0 or specific IP)
- [ ] Connection string copied and tested

### 🔧 **Environment Configuration**
- [ ] Backend `.env` file created with production values
- [ ] Frontend `.env.production` file created
- [ ] JWT_SECRET set to secure random string (32+ characters)
- [ ] MONGODB_URI updated with Atlas connection string
- [ ] CLIENT_ORIGIN set to your domain (https://yourdomain.com)

### 🏗️ **Build Process**
- [ ] Frontend dependencies installed (`npm install`)
- [ ] Frontend built for production (`npm run build:prod`)
- [ ] Backend dependencies installed (`npm install --production`)
- [ ] Admin user created (`npm run setup-admin`)

---

## 🚀 **Deployment Steps**

### 1. **Upload Files to Hostinger**
- [ ] Login to Hostinger Control Panel
- [ ] Open File Manager
- [ ] Navigate to `public_html` folder
- [ ] Upload frontend build files (from `glinthive/dist/`)
- [ ] Upload backend folder to `public_html/backend/`
- [ ] Upload `.env` file to backend folder

### 2. **Server Configuration**
- [ ] Enable Node.js in Hostinger (Advanced → Node.js)
- [ ] Set Node.js version to 18.x
- [ ] Set Application Root to `/backend`
- [ ] Set Application URL to your domain

### 3. **Install PM2 (Process Manager)**
```bash
npm install -g pm2
```

### 4. **Start Application**
```bash
cd backend
pm2 start ecosystem.config.js --env production
pm2 save
pm2 startup
```

---

## 🧪 **Testing Checklist**

### **Frontend Testing**
- [ ] Website loads at `https://yourdomain.com`
- [ ] All pages accessible
- [ ] Contact form submits successfully
- [ ] Free advice form submits successfully
- [ ] Mobile responsive design works

### **Backend Testing**
- [ ] API health check: `https://yourdomain.com/api/health`
- [ ] Contact form API: `https://yourdomain.com/api/contact`
- [ ] Advice form API: `https://yourdomain.com/api/advice`

### **Admin Panel Testing**
- [ ] Admin login: `https://yourdomain.com/admin/login`
- [ ] Dashboard loads with statistics
- [ ] Contact submissions visible
- [ ] Advice submissions visible
- [ ] Password change functionality works

---

## 🔐 **Security Checklist**

- [ ] SSL certificate enabled (Let's Encrypt)
- [ ] HTTPS redirect enabled
- [ ] Strong JWT_SECRET set (32+ characters)
- [ ] Database user has limited permissions
- [ ] Environment variables not exposed in code
- [ ] CORS properly configured
- [ ] Admin password changed from default

---

## 📊 **Monitoring Setup**

- [ ] PM2 monitoring enabled (`pm2 monit`)
- [ ] Log files accessible
- [ ] Error tracking configured
- [ ] Performance monitoring set up

---

## 🚨 **Common Issues & Solutions**

### **CORS Errors**
- [ ] Check `CLIENT_ORIGIN` in backend `.env`
- [ ] Ensure frontend URL matches exactly
- [ ] Verify HTTPS/HTTP protocol matches

### **Database Connection Issues**
- [ ] Verify MongoDB Atlas connection string
- [ ] Check network access settings
- [ ] Confirm database user permissions

### **Build Errors**
- [ ] Clear `node_modules` and reinstall
- [ ] Check Node.js version compatibility
- [ ] Verify all dependencies installed

### **Admin Login Issues**
- [ ] Run `npm run setup-admin` again
- [ ] Check JWT_SECRET is set correctly
- [ ] Verify admin user exists in database

---

## 📞 **Post-Deployment**

### **Immediate Actions**
- [ ] Test all functionality
- [ ] Change default admin password
- [ ] Set up monitoring
- [ ] Create backup strategy

### **Ongoing Maintenance**
- [ ] Regular database backups
- [ ] Monitor server performance
- [ ] Update dependencies regularly
- [ ] Review security settings

---

## 🎉 **Success Criteria**

Your deployment is successful when:
- ✅ Website loads without errors
- ✅ Forms submit successfully
- ✅ Admin panel accessible and functional
- ✅ All pages responsive on mobile
- ✅ SSL certificate working
- ✅ No console errors in browser
- ✅ API endpoints responding correctly

---

## 📚 **Useful Commands**

```bash
# Check PM2 status
pm2 status

# View logs
pm2 logs glinthive-backend

# Restart application
pm2 restart glinthive-backend

# Monitor in real-time
pm2 monit

# Stop application
pm2 stop glinthive-backend
```

---

**🎯 Ready to deploy? Follow the DEPLOYMENT_GUIDE.md for detailed instructions!**
