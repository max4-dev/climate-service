/*
  Warnings:

  - You are about to drop the column `email` on the `Client` table. All the data in the column will be lost.
  - You are about to drop the column `email` on the `User` table. All the data in the column will be lost.
  - A unique constraint covering the columns `[phone]` on the table `User` will be added. If there are existing duplicate values, this will fail.
  - Made the column `phone` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- DropIndex
DROP INDEX "Client_email_idx";

-- DropIndex
DROP INDEX "Client_email_key";

-- DropIndex
DROP INDEX "User_email_idx";

-- DropIndex
DROP INDEX "User_email_key";

-- AlterTable
ALTER TABLE "Client" DROP COLUMN "email";

-- AlterTable
ALTER TABLE "User" DROP COLUMN "email",
ALTER COLUMN "phone" SET NOT NULL;

-- CreateIndex
CREATE UNIQUE INDEX "User_phone_key" ON "User"("phone");

-- CreateIndex
CREATE INDEX "User_phone_idx" ON "User"("phone");
