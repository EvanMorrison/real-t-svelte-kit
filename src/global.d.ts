/// <reference types="@sveltejs/kit" />

interface User {
  userId: string;
  firstName: string;
  lastName?: string;
  email: string;
  password?: string;
  avatar?: string;
  role: 'user' | 'admin'
  createdAt: string;
}
