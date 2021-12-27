/*
  Warnings:

  - You are about to drop the column `emailId` on the `Person` table. All the data in the column will be lost.
  - You are about to drop the column `phoneId` on the `Person` table. All the data in the column will be lost.

*/
-- DropForeignKey
ALTER TABLE "Person" DROP CONSTRAINT "Person_emailId_fkey";

-- DropForeignKey
ALTER TABLE "Person" DROP CONSTRAINT "Person_phoneId_fkey";

-- DropIndex
DROP INDEX "Person_emailId_key";

-- DropIndex
DROP INDEX "Person_phoneId_key";

-- AlterTable
ALTER TABLE "Person" DROP COLUMN "emailId",
DROP COLUMN "phoneId";
