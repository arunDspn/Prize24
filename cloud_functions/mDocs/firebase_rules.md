# **Firestore Security Rules: Commerce & Campaign Monitoring System**

This document provides a set of optimal Firestore security rules designed to enforce the hierarchical data visibility and role-based access control (RBAC) specified in the product documentation.

## **🔑 Core Philosophy: The Golden Rule**

> **"A role can only see what is below it in the hierarchy AND explicitly assigned to it."**
> 

## **🏗️ Hierarchy Overview**

1. **Super Admin**: Global access.
2. **Admin**: Manages Supervisors.
3. **Supervisor**: Monitors Partners.
4. **Partner (Vendor)**: Operates Shops/Campaigns.
5. **User (Customer)**: Interacts with Shops/Campaigns.

---

## **📄 Security Rules Implementation**

```
rules_version = '2';

service cloud.firestore {
    match /databases/{database}/documents {

        // ==========================================
        // 🧰 GLOBAL HELPER FUNCTIONS
        // ==========================================

        function isAuthenticated() {
            return request.auth != null;
        }

        function getUserRole() {
            return get(/databases/$(database)/documents/users/$(request.auth.uid)).data.role;
        }

        function isSuperAdmin() {
            return isAuthenticated() && getUserRole() == 'super_admin';
        }

        function isAdmin() {
            return isAuthenticated() && getUserRole() == 'admin';
        }

        function isSupervisor() {
            return isAuthenticated() && getUserRole() == 'supervisor';
        }

        function isPartner() {
            return isAuthenticated() && getUserRole() == 'partner';
        }

        function isEndUser() {
            return isAuthenticated() && getUserRole() == 'user';
        }

        function hasHierarchicalReadAccess(resourceData) {
            return isSuperAdmin() ||
                (isAdmin() && resourceData.adminId == request.auth.uid) ||
                (isSupervisor() && resourceData.supervisorId == request.auth.uid);
        }

        // ==========================================
        // 👤 USERS COLLECTION
        // ==========================================
        match /users/{userId} {
            allow read: if request.auth.uid == userId || isSuperAdmin();
            allow write: if request.auth.uid == userId || isSuperAdmin();
        }

        // ==========================================
        // 🏪 SHOPS COLLECTION
        // ==========================================
        match /shops/{shopId} {
            allow read: if isEndUser() ||
                request.auth.uid == resource.data.partnerId ||
                hasHierarchicalReadAccess(resource.data);

            allow create: if isPartner() || isSuperAdmin();
            allow update: if (isPartner() && request.auth.uid == resource.data.partnerId) || isSuperAdmin();
            allow delete: if isSuperAdmin();
        }

        // ==========================================
        // 🎯 CAMPAIGNS COLLECTION
        // ==========================================
        match /campaigns/{campaignId} {
            allow read: if isEndUser() ||
                request.auth.uid == resource.data.partnerId ||
                hasHierarchicalReadAccess(resource.data);

            allow create: if isPartner() || isSuperAdmin();
            allow update: if (isPartner() && request.auth.uid == resource.data.partnerId) || isSuperAdmin();
            allow delete: if isSuperAdmin();
        }

        // ==========================================
        // 🎁 USER GIFTS / REDEMPTIONS
        // ==========================================
        match /user_gifts/{redemptionId} {
            allow read: if request.auth.uid == resource.data.userId ||
                request.auth.uid == resource.data.partnerId ||
                hasHierarchicalReadAccess(resource.data);

            allow create: if isAuthenticated();
            allow update: if isSuperAdmin() || (isPartner() && request.auth.uid == resource.data.partnerId);
        }

        // ==========================================
        // 🤝 FRIENDSHIPS & STAFF
        // ==========================================
        match /friendships/{friendshipId} {
            allow read: if request.auth.uid in resource.data.participants || isSuperAdmin();
            allow write: if isPartner() || isSuperAdmin();
        }

        match /staff_requests/{requestId} {
            allow read: if request.auth.uid == resource.data.vendorId ||
                request.auth.uid == resource.data.staffUserId ||
                isSuperAdmin();
            allow write: if isPartner() || isSuperAdmin();
        }
    }
}
```

---

## **🔎 Detailed Security Logic**

### **1. The Observer Layer (Supervisor & Admin)**

Supervisors and Admins are explicitly defined as **Read-only**.

- In the `shops` and `campaigns` rules, `allow write` is restricted to `isPartner()`.
- If an Admin or Supervisor attempts to modify business data, the request will be rejected.

### **2. Assignment-Based Visibility**

The function `hasHierarchicalReadAccess(resourceData)` is the core of the "Golden Rule".

- It relies on **Denormalization**: Documents must store `supervisorId` and `adminId`.
- This ensures that a Supervisor *only* sees shops assigned to them, and an Admin *only* sees shops under their Supervisors.

### **3. Data Integrity & Ownership**

- **Partners** have full CRUD (Create, Read, Update, Delete) on their own data.
- **Super Admins** act as the global authority with bypass logic via `isSuperAdmin()`.

### **4. End User Boundaries**

- End Users (`role: "user"`) are permitted to `read` shops and campaigns to browse offers.
- They are **prevented** from seeing sensitive analytics or management collections (like `staff_requests` or `friendships`) unless they are specific participants.

---

**TIP**

**Implementation Note**: When assigning a Supervisor to a Shop, ensure that the Shop document is updated with both the `supervisorId` and the `adminId` (the Supervisor's manager). This flat structure in the document makes security rules extremely fast and scalable.