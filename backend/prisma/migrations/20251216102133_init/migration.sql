/*
  Warnings:

  - You are about to drop the `Client` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Requests" DROP CONSTRAINT "Requests_clientID_fkey";

-- DropTable
DROP TABLE "Client";

-- AddForeignKey
ALTER TABLE "Requests" ADD CONSTRAINT "Requests_clientID_fkey" FOREIGN KEY ("clientID") REFERENCES "User"("id") ON DELETE RESTRICT ON UPDATE CASCADE;
