import { RootLayout } from "@/app/layout/RootLayout/RootLayout";
import { LoginPage, RegisterPage } from "@/pages/auth/ui";
import { RequestPage } from "@/pages/request/ui/RequestPage/RequestPage";
import { BrowserRouter, Route, Routes } from "react-router";
import { RequireAuth } from "../RequireAuth/RequireAuth";

export const RouterProvider = () => {
  return (
  <BrowserRouter>
    <Routes>
      <Route path="/login" element={<LoginPage />} />
      <Route path="/register" element={<RegisterPage />} />
      <Route element={<RequireAuth />}>
        <Route path="/" element={<RootLayout />}>
          <Route index element={<RequestPage />} />
        </Route>
      </Route>
    </Routes>
  </BrowserRouter>
)}