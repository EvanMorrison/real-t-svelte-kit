/*
  Warnings:

  - You are about to drop the column `category` on the `Email` table. All the data in the column will be lost.
  - The primary key for the `PartiesInProjects` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `partyId` on the `PartiesInProjects` table. All the data in the column will be lost.
  - You are about to drop the column `projectDisplayIndex` on the `PartiesInProjects` table. All the data in the column will be lost.
  - You are about to drop the column `firstName` on the `Person` table. All the data in the column will be lost.
  - You are about to drop the column `lastName` on the `Person` table. All the data in the column will be lost.
  - You are about to drop the column `middleName` on the `Person` table. All the data in the column will be lost.
  - You are about to drop the column `orgId` on the `Person` table. All the data in the column will be lost.
  - You are about to alter the column `extension` on the `Phone` table. The data in that column could be lost. The data in that column will be cast from `Text` to `VarChar(16)`.
  - You are about to drop the column `personId` on the `User` table. All the data in the column will be lost.
  - You are about to drop the `Party` table. If the table is not empty, all the data it contains will be lost.
  - Added the required column `createdById` to the `Org` table without a default value. This is not possible if the table is not empty.
  - Added the required column `createdById` to the `Person` table without a default value. This is not possible if the table is not empty.

*/
-- DropForeignKey
ALTER TABLE "PartiesInProjects" DROP CONSTRAINT "PartiesInProjects_partyId_fkey";

-- DropForeignKey
ALTER TABLE "Party" DROP CONSTRAINT "Party_orgId_fkey";

-- DropForeignKey
ALTER TABLE "Party" DROP CONSTRAINT "Party_personId_fkey";

-- DropForeignKey
ALTER TABLE "Person" DROP CONSTRAINT "Person_orgId_fkey";

-- DropForeignKey
ALTER TABLE "User" DROP CONSTRAINT "User_personId_fkey";

-- DropIndex
DROP INDEX "User_personId_key";

-- AlterTable
ALTER TABLE "Email" DROP COLUMN "category";

-- AlterTable
ALTER TABLE "Org" ADD COLUMN     "country" VARCHAR(255) DEFAULT E'USA',
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "createdById" INTEGER NOT NULL,
ADD COLUMN     "fullLegalName" TEXT,
ADD COLUMN     "updatedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" INTEGER,
ALTER COLUMN "name" SET DATA TYPE TEXT;

-- AlterTable
ALTER TABLE "PartiesInProjects" DROP CONSTRAINT "PartiesInProjects_pkey",
DROP COLUMN "partyId",
DROP COLUMN "projectDisplayIndex",
ADD COLUMN     "isPrimary" BOOLEAN NOT NULL DEFAULT false,
ADD COLUMN     "orgId" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "partiesInProjectsOrgId" INTEGER,
ADD COLUMN     "partiesInProjectsPersonId" INTEGER,
ADD COLUMN     "partiesInProjectsProjectId" INTEGER,
ADD COLUMN     "personId" INTEGER NOT NULL DEFAULT 0,
ADD COLUMN     "role" VARCHAR(255),
ADD COLUMN     "worksForId" INTEGER,
ADD CONSTRAINT "PartiesInProjects_pkey" PRIMARY KEY ("projectId", "orgId", "personId");

-- AlterTable
ALTER TABLE "Person" DROP COLUMN "firstName",
DROP COLUMN "lastName",
DROP COLUMN "middleName",
DROP COLUMN "orgId",
ADD COLUMN     "avatar" TEXT,
ADD COLUMN     "city" VARCHAR(255),
ADD COLUMN     "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
ADD COLUMN     "createdById" INTEGER NOT NULL,
ADD COLUMN     "email" VARCHAR(255),
ADD COLUMN     "fullName" TEXT,
ADD COLUMN     "nickname" VARCHAR(64),
ADD COLUMN     "orgName" TEXT,
ADD COLUMN     "phone" VARCHAR(64),
ADD COLUMN     "state" VARCHAR(255),
ADD COLUMN     "street1" VARCHAR(255),
ADD COLUMN     "street2" VARCHAR(255),
ADD COLUMN     "title" VARCHAR(255),
ADD COLUMN     "updatedAt" TIMESTAMP(3),
ADD COLUMN     "updatedById" INTEGER,
ADD COLUMN     "userUserId" INTEGER,
ADD COLUMN     "zipCode" VARCHAR(15);

-- AlterTable
ALTER TABLE "Phone" ALTER COLUMN "countryCode" SET DEFAULT E'10',
ALTER COLUMN "countryCode" SET DATA TYPE TEXT,
ALTER COLUMN "phone" SET DATA TYPE VARCHAR(16),
ALTER COLUMN "extension" SET DATA TYPE VARCHAR(16);

-- AlterTable
ALTER TABLE "User" DROP COLUMN "personId";

-- DropTable
DROP TABLE "Party";

-- AddForeignKey
ALTER TABLE "Org" ADD CONSTRAINT "Org_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Org" ADD CONSTRAINT "Org_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "User"("userId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Person" ADD CONSTRAINT "Person_createdById_fkey" FOREIGN KEY ("createdById") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Person" ADD CONSTRAINT "Person_updatedById_fkey" FOREIGN KEY ("updatedById") REFERENCES "User"("userId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartiesInProjects" ADD CONSTRAINT "PartiesInProjects_partiesInProjectsProjectId_partiesInProj_fkey" FOREIGN KEY ("partiesInProjectsProjectId", "partiesInProjectsOrgId", "partiesInProjectsPersonId") REFERENCES "PartiesInProjects"("projectId", "orgId", "personId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartiesInProjects" ADD CONSTRAINT "PartiesInProjects_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Org"("orgId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartiesInProjects" ADD CONSTRAINT "PartiesInProjects_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person"("personId") ON DELETE RESTRICT ON UPDATE CASCADE;
