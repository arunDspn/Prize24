/// <reference types="vite/client" />

interface ImportMetaEnv {
    readonly VITE_FIREBASE_API_KEY: string;
    readonly VITE_FIREBASE_AUTH_DOMAIN: string;
    readonly VITE_FIREBASE_PROJECT_ID: string;
    readonly VITE_FIREBASE_STORAGE_BUCKET: string;
    readonly VITE_FIREBASE_MESSAGING_SENDER_ID: string;
    readonly VITE_FIREBASE_APP_ID: string;
    readonly VITE_FIREBASE_USERS_COLLECTION?: string;
    readonly VITE_FIREBASE_INVITES_COLLECTION?: string;
}

/**
 * // Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyB7-Q8cxEnorxb4xvtG6wbhxzVTUaAhDJI",
  authDomain: "prize24-dev.firebaseapp.com",
  projectId: "prize24-dev",
  storageBucket: "prize24-dev.firebasestorage.app",
  messagingSenderId: "658213032436",
  appId: "1:658213032436:web:b8740110ff49fa43bea9a1"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
 */

interface ImportMeta {
    readonly env: ImportMetaEnv;
}
