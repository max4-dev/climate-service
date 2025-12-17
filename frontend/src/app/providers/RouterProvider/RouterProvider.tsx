import { RootLayout } from "@/app/layout/RootLayout/RootLayout";
import { BrowserRouter, Route, Routes } from "react-router";

export const RouterProvider = () => {
  return (
  <BrowserRouter>
    <Routes>
      <Route path="/" element={<RootLayout />}>
      </Route>
    </Routes>
  </BrowserRouter>
)}