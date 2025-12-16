/*
  Warnings:

  - The `requestId` column on the `Notification` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - You are about to drop the `Comment` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Request` table. If the table is not empty, all the data it contains will be lost.
  - Changed the type of `requestId` on the `OrderedPart` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `requestId` on the `StatusHistory` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `oldStatus` on the `StatusHistory` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.
  - Changed the type of `newStatus` on the `StatusHistory` table. No cast exists, the column would be dropped and recreated, which cannot be done if there is data, since the column is required.

*/
-- CreateEnum
CREATE TYPE "requestStatus" AS ENUM ('OPEN', 'IN_PROGRESS', 'WAITING_PARTS', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "climateTechType" AS ENUM ('CONDITIONER', 'SPLIT_SYSTEM', 'WINDOW_AC', 'CENTRAL_AC', 'PORTABLE_AC', 'HEAT_PUMP', 'OTHER');

-- DropForeignKey
ALTER TABLE "Comment" DROP CONSTRAINT "Comment_authorId_fkey";

-- DropForeignKey
ALTER TABLE "Comment" DROP CONSTRAINT "Comment_requestId_fkey";

-- DropForeignKey
ALTER TABLE "Notification" DROP CONSTRAINT "Notification_requestId_fkey";

-- DropForeignKey
ALTER TABLE "OrderedPart" DROP CONSTRAINT "OrderedPart_requestId_fkey";

-- DropForeignKey
ALTER TABLE "Request" DROP CONSTRAINT "Request_assignedToId_fkey";

-- DropForeignKey
ALTER TABLE "Request" DROP CONSTRAINT "Request_clientId_fkey";

-- DropForeignKey
ALTER TABLE "Request" DROP CONSTRAINT "Request_createdById_fkey";

-- DropForeignKey
ALTER TABLE "StatusHistory" DROP CONSTRAINT "StatusHistory_requestId_fkey";

-- AlterTable
ALTER TABLE "Notification" DROP COLUMN "requestId",
ADD COLUMN     "requestId" INTEGER;

-- AlterTable
ALTER TABLE "OrderedPart" DROP COLUMN "requestId",
ADD COLUMN     "requestId" INTEGER NOT NULL;

-- AlterTable
ALTER TABLE "StatusHistory" DROP COLUMN "requestId",
ADD COLUMN     "requestId" INTEGER NOT NULL,
DROP COLUMN "oldStatus",
ADD COLUMN     "oldStatus" "requestStatus" NOT NULL,
DROP COLUMN "newStatus",
ADD COLUMN     "newStatus" "requestStatus" NOT NULL;

-- DropTable
DROP TABLE "Comment";

-- DropTable
DROP TABLE "Request";

-- DropEnum
DROP TYPE "RequestStatus";

-- CreateTable
CREATE TABLE "Requests" (
    "requestID" SERIAL NOT NULL,
    "startDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "climateTechType" "climateTechType" NOT NULL,
    "climateTechModel" TEXT NOT NULL,
    "problemDescryption" TEXT NOT NULL,
    "requestStatus" "requestStatus" NOT NULL DEFAULT 'OPEN',
    "completionDate" TIMESTAMP(3),
    "repairParts" TEXT,
    "masterID" TEXT,
    "clientID" TEXT NOT NULL,
    "createdById" TEXT NOT NULL,
    "assignedToId" TEXT,

    CONSTRAINT "Requests_pkey" PRIMARY KEY ("requestID")
);

-- CreateTable
CREATE TABLE "Comments" (
    "commentID" SERIAL NOT NULL,
    "message" TEXT NOT NULL,
    "requestID" INTEGER NOT NULL,
    "masterID" TEXT NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Comments_pkey" PRIMARY KEY ("commentID")
);

-- CreateIndex
CREATE INDEX "Comments_createdAt_idx" ON "Comments"("createdAt");

-- CreateIndex
CREATE INDEX "OrderedPart_requestId_idx" ON "OrderedPart"("requestId");

-- CreateIndex
CREATE INDEX "StatusHistory_requestId_idx" ON "StatusHistory"("requestId");

-- AddForeignKey
ALTER TABLE "Requests" ADD CONSTRAINT "Requests_masterID_fkey" FOREIGN KEY ("masterID") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Requests" ADD CONSTRAINT "Requests_clientID_fkey" FOREIGN KEY ("clientID") REFERENCES "Client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Requests" ADD CONSTRAINT "Requests_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Requests" ADD CONSTRAINT "Requests_assignedToId_fkey" FOREIGN KEY ("assignedToId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StatusHistory" ADD CONSTRAINT "StatusHistory_requestId_fkey" FOREIGN KEY ("requestId") REFERENCES "Requests"("requestID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comments" ADD CONSTRAINT "Comments_requestID_fkey" FOREIGN KEY ("requestID") REFERENCES "Requests"("requestID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comments" ADD CONSTRAINT "Comments_masterID_fkey" FOREIGN KEY ("masterID") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderedPart" ADD CONSTRAINT "OrderedPart_requestId_fkey" FOREIGN KEY ("requestId") REFERENCES "Requests"("requestID") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_requestId_fkey" FOREIGN KEY ("requestId") REFERENCES "Requests"("requestID") ON DELETE SET NULL ON UPDATE CASCADE;
