-- CreateEnum
CREATE TYPE "RequestStatus" AS ENUM ('OPEN', 'IN_PROGRESS', 'WAITING_PARTS', 'COMPLETED', 'CANCELLED');

-- CreateEnum
CREATE TYPE "EquipmentType" AS ENUM ('SPLIT_SYSTEM', 'WINDOW_AC', 'CENTRAL_AC', 'PORTABLE_AC', 'HEAT_PUMP', 'OTHER');

-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('ADMIN', 'MANAGER', 'SPECIALIST', 'CLIENT');

-- CreateEnum
CREATE TYPE "NotificationType" AS ENUM ('STATUS_CHANGED', 'ASSIGNED_TO_YOU', 'COMMENT_ADDED', 'PARTS_ORDERED', 'COMPLETION');

-- CreateTable
CREATE TABLE "User" (
    "id" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "phone" TEXT,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "UserRole" NOT NULL DEFAULT 'SPECIALIST',
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "User_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Client" (
    "id" TEXT NOT NULL,
    "firstName" TEXT NOT NULL,
    "lastName" TEXT NOT NULL,
    "phone" TEXT NOT NULL,
    "email" TEXT,
    "address" TEXT,
    "company" TEXT,
    "notes" TEXT,
    "isActive" BOOLEAN NOT NULL DEFAULT true,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Client_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Request" (
    "id" TEXT NOT NULL,
    "ticketNumber" TEXT NOT NULL,
    "equipmentType" "EquipmentType" NOT NULL,
    "equipmentModel" TEXT NOT NULL,
    "problemDescription" TEXT NOT NULL,
    "clientId" TEXT NOT NULL,
    "status" "RequestStatus" NOT NULL DEFAULT 'OPEN',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "completedAt" TIMESTAMP(3),
    "createdById" TEXT NOT NULL,
    "assignedToId" TEXT,
    "estimatedCompletionDate" TIMESTAMP(3),
    "priority" INTEGER NOT NULL DEFAULT 1,
    "notes" TEXT,

    CONSTRAINT "Request_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "StatusHistory" (
    "id" TEXT NOT NULL,
    "requestId" TEXT NOT NULL,
    "oldStatus" "RequestStatus" NOT NULL,
    "newStatus" "RequestStatus" NOT NULL,
    "changedAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "changedById" TEXT,
    "reason" TEXT,

    CONSTRAINT "StatusHistory_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Comment" (
    "id" TEXT NOT NULL,
    "requestId" TEXT NOT NULL,
    "authorId" TEXT NOT NULL,
    "content" TEXT NOT NULL,
    "isInternal" BOOLEAN NOT NULL DEFAULT false,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "Comment_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "OrderedPart" (
    "id" TEXT NOT NULL,
    "requestId" TEXT NOT NULL,
    "partName" TEXT NOT NULL,
    "partNumber" TEXT,
    "quantity" INTEGER NOT NULL DEFAULT 1,
    "unitPrice" DOUBLE PRECISION,
    "totalPrice" DOUBLE PRECISION,
    "supplier" TEXT,
    "orderDate" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "expectedDeliveryDate" TIMESTAMP(3),
    "actualDeliveryDate" TIMESTAMP(3),
    "status" TEXT NOT NULL DEFAULT 'ORDERED',
    "notes" TEXT,

    CONSTRAINT "OrderedPart_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "Notification" (
    "id" TEXT NOT NULL,
    "userId" TEXT NOT NULL,
    "requestId" TEXT,
    "type" "NotificationType" NOT NULL,
    "title" TEXT NOT NULL,
    "message" TEXT NOT NULL,
    "isRead" BOOLEAN NOT NULL DEFAULT false,
    "readAt" TIMESTAMP(3),
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "Notification_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "AuditLog" (
    "id" TEXT NOT NULL,
    "userId" TEXT,
    "action" TEXT NOT NULL,
    "entityType" TEXT NOT NULL,
    "entityId" TEXT NOT NULL,
    "oldValue" TEXT,
    "newValue" TEXT,
    "ipAddress" TEXT,
    "userAgent" TEXT,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "AuditLog_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DefectStatistic" (
    "id" TEXT NOT NULL,
    "equipmentType" "EquipmentType" NOT NULL,
    "defectType" TEXT NOT NULL,
    "totalCount" INTEGER NOT NULL DEFAULT 0,
    "averageRepairTime" DOUBLE PRECISION,
    "completionRate" DOUBLE PRECISION,
    "lastUpdated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DefectStatistic_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "DepartmentStatistic" (
    "id" TEXT NOT NULL,
    "totalRequests" INTEGER NOT NULL DEFAULT 0,
    "completedRequests" INTEGER NOT NULL DEFAULT 0,
    "inProgressRequests" INTEGER NOT NULL DEFAULT 0,
    "averageRepairTime" DOUBLE PRECISION,
    "periodStartDate" TIMESTAMP(3) NOT NULL,
    "periodEndDate" TIMESTAMP(3) NOT NULL,
    "lastUpdated" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "DepartmentStatistic_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE INDEX "User_email_idx" ON "User"("email");

-- CreateIndex
CREATE INDEX "User_role_idx" ON "User"("role");

-- CreateIndex
CREATE UNIQUE INDEX "Client_phone_key" ON "Client"("phone");

-- CreateIndex
CREATE UNIQUE INDEX "Client_email_key" ON "Client"("email");

-- CreateIndex
CREATE INDEX "Client_phone_idx" ON "Client"("phone");

-- CreateIndex
CREATE INDEX "Client_email_idx" ON "Client"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Request_ticketNumber_key" ON "Request"("ticketNumber");

-- CreateIndex
CREATE INDEX "Request_ticketNumber_idx" ON "Request"("ticketNumber");

-- CreateIndex
CREATE INDEX "Request_status_idx" ON "Request"("status");

-- CreateIndex
CREATE INDEX "Request_clientId_idx" ON "Request"("clientId");

-- CreateIndex
CREATE INDEX "Request_assignedToId_idx" ON "Request"("assignedToId");

-- CreateIndex
CREATE INDEX "Request_createdAt_idx" ON "Request"("createdAt");

-- CreateIndex
CREATE INDEX "StatusHistory_requestId_idx" ON "StatusHistory"("requestId");

-- CreateIndex
CREATE INDEX "StatusHistory_changedAt_idx" ON "StatusHistory"("changedAt");

-- CreateIndex
CREATE INDEX "Comment_requestId_idx" ON "Comment"("requestId");

-- CreateIndex
CREATE INDEX "Comment_authorId_idx" ON "Comment"("authorId");

-- CreateIndex
CREATE INDEX "Comment_createdAt_idx" ON "Comment"("createdAt");

-- CreateIndex
CREATE INDEX "OrderedPart_requestId_idx" ON "OrderedPart"("requestId");

-- CreateIndex
CREATE INDEX "OrderedPart_status_idx" ON "OrderedPart"("status");

-- CreateIndex
CREATE INDEX "Notification_userId_idx" ON "Notification"("userId");

-- CreateIndex
CREATE INDEX "Notification_isRead_idx" ON "Notification"("isRead");

-- CreateIndex
CREATE INDEX "Notification_createdAt_idx" ON "Notification"("createdAt");

-- CreateIndex
CREATE INDEX "AuditLog_userId_idx" ON "AuditLog"("userId");

-- CreateIndex
CREATE INDEX "AuditLog_action_idx" ON "AuditLog"("action");

-- CreateIndex
CREATE INDEX "AuditLog_createdAt_idx" ON "AuditLog"("createdAt");

-- CreateIndex
CREATE INDEX "DefectStatistic_equipmentType_idx" ON "DefectStatistic"("equipmentType");

-- CreateIndex
CREATE UNIQUE INDEX "DefectStatistic_equipmentType_defectType_key" ON "DefectStatistic"("equipmentType", "defectType");

-- CreateIndex
CREATE INDEX "DepartmentStatistic_lastUpdated_idx" ON "DepartmentStatistic"("lastUpdated");

-- CreateIndex
CREATE UNIQUE INDEX "DepartmentStatistic_periodStartDate_periodEndDate_key" ON "DepartmentStatistic"("periodStartDate", "periodEndDate");

-- AddForeignKey
ALTER TABLE "Request" ADD CONSTRAINT "Request_clientId_fkey" FOREIGN KEY ("clientId") REFERENCES "Client"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Request" ADD CONSTRAINT "Request_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Request" ADD CONSTRAINT "Request_assignedToId_fkey" FOREIGN KEY ("assignedToId") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StatusHistory" ADD CONSTRAINT "StatusHistory_requestId_fkey" FOREIGN KEY ("requestId") REFERENCES "Request"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "StatusHistory" ADD CONSTRAINT "StatusHistory_changedById_fkey" FOREIGN KEY ("changedById") REFERENCES "User"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_requestId_fkey" FOREIGN KEY ("requestId") REFERENCES "Request"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Comment" ADD CONSTRAINT "Comment_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "OrderedPart" ADD CONSTRAINT "OrderedPart_requestId_fkey" FOREIGN KEY ("requestId") REFERENCES "Request"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Notification" ADD CONSTRAINT "Notification_requestId_fkey" FOREIGN KEY ("requestId") REFERENCES "Request"("id") ON DELETE SET NULL ON UPDATE CASCADE;
