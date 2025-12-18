export interface UserDTO {
  id: string;
  phone: string;
  login: string;
  name: string;
  role: "ADMIN" | "MANAGER" | "SPECIALIST" | "CLIENT";
  createdAt: Date;
  updatedAt: Date;
}

export interface UserView {
  id: string;
  phone: string;
  login: string;
  name: string;
  role: "ADMIN" | "MANAGER" | "SPECIALIST" | "CLIENT";
}