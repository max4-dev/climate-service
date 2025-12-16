/*
  Warnings:

  - You are about to drop the column `assignedToId` on the `Requests` table. All the data in the column will be lost.
  - You are about to drop the column `createdById` on the `Requests` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Requests" DROP CONSTRAINT "Requests_assignedToId_fkey";

-- DropForeignKey
ALTER TABLE "Requests" DROP CONSTRAINT "Requests_createdById_fkey";

-- AlterTable
ALTER TABLE "Requests" DROP COLUMN "assignedToId",
DROP COLUMN "createdById";
