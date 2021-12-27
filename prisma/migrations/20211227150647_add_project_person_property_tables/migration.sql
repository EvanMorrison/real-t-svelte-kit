/*
  Warnings:

  - The `role` column on the `User` table would be dropped and recreated. This will lead to data loss if there is data in the column.
  - A unique constraint covering the columns `[personId]` on the table `User` will be added. If there are existing duplicate values, this will fail.

*/
-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('GUEST', 'USER', 'ADMIN');

-- AlterTable
ALTER TABLE "User" ADD COLUMN     "personId" INTEGER,
DROP COLUMN "role",
ADD COLUMN     "role" "UserRole" NOT NULL DEFAULT E'USER';

-- DropEnum
DROP TYPE "Role";

-- CreateTable
CREATE TABLE "Org" (
    "orgId" SERIAL NOT NULL,
    "name" VARCHAR(255),
    "street1" VARCHAR(255),
    "street2" VARCHAR(255),
    "city" VARCHAR(255),
    "state" VARCHAR(255),
    "zipCode" VARCHAR(15),
    "orgType" VARCHAR(255),
    "parentId" INTEGER,
    "notes" TEXT,

    CONSTRAINT "Org_pkey" PRIMARY KEY ("orgId")
);

-- CreateTable
CREATE TABLE "Person" (
    "personId" SERIAL NOT NULL,
    "prefix" VARCHAR(255),
    "firstName" VARCHAR(255),
    "middleName" VARCHAR(255),
    "lastName" VARCHAR(255),
    "suffix" VARCHAR(255),
    "emailId" INTEGER,
    "phoneId" INTEGER,
    "orgId" INTEGER,
    "notes" TEXT,

    CONSTRAINT "Person_pkey" PRIMARY KEY ("personId")
);

-- CreateTable
CREATE TABLE "PeopleInOrgs" (
    "personId" INTEGER NOT NULL,
    "orgId" INTEGER NOT NULL,
    "title" VARCHAR(255),

    CONSTRAINT "PeopleInOrgs_pkey" PRIMARY KEY ("personId","orgId")
);

-- CreateTable
CREATE TABLE "Email" (
    "emailId" SERIAL NOT NULL,
    "category" VARCHAR(64),
    "email" VARCHAR(255) NOT NULL,
    "isPrimary" BOOLEAN NOT NULL DEFAULT false,
    "personId" INTEGER NOT NULL,

    CONSTRAINT "Email_pkey" PRIMARY KEY ("emailId")
);

-- CreateTable
CREATE TABLE "Phone" (
    "phoneId" SERIAL NOT NULL,
    "category" VARCHAR(64),
    "countryCode" INTEGER DEFAULT 10,
    "phone" INTEGER NOT NULL,
    "extension" TEXT,
    "personId" INTEGER NOT NULL,
    "isPrimary" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Phone_pkey" PRIMARY KEY ("phoneId")
);

-- CreateTable
CREATE TABLE "Property" (
    "propertyId" SERIAL NOT NULL,
    "street1" VARCHAR(255),
    "street2" VARCHAR(255),
    "city" VARCHAR(255),
    "state" VARCHAR(255),
    "zipCode" VARCHAR(15),
    "country" VARCHAR(255) DEFAULT E'USA',
    "county" VARCHAR(255),
    "parcelId" VARCHAR(64),
    "shortDescription" TEXT,
    "legalDescription" TEXT,

    CONSTRAINT "Property_pkey" PRIMARY KEY ("propertyId")
);

-- CreateTable
CREATE TABLE "Project" (
    "projectId" SERIAL NOT NULL,
    "projectType" VARCHAR(64),
    "createdByUserId" INTEGER NOT NULL,
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedbyUserId" INTEGER,
    "updatedAt" TIMESTAMP(3) NOT NULL,
    "roles" TEXT[],

    CONSTRAINT "Project_pkey" PRIMARY KEY ("projectId")
);

-- CreateTable
CREATE TABLE "PropertiesInProjects" (
    "propertyId" INTEGER NOT NULL,
    "projectId" INTEGER NOT NULL,
    "vesting" TEXT,
    "assessedValue" INTEGER,
    "assessedYear" INTEGER,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "PropertiesInProjects_pkey" PRIMARY KEY ("propertyId","projectId")
);

-- CreateTable
CREATE TABLE "Party" (
    "partyId" SERIAL NOT NULL,
    "role" VARCHAR(255),
    "isOrg" BOOLEAN NOT NULL DEFAULT false,
    "personId" INTEGER,
    "orgId" INTEGER,

    CONSTRAINT "Party_pkey" PRIMARY KEY ("partyId")
);

-- CreateTable
CREATE TABLE "PartiesInProjects" (
    "projectId" INTEGER NOT NULL,
    "partyId" INTEGER NOT NULL,
    "partyDisplayIndex" INTEGER DEFAULT 0,
    "projectDisplayIndex" INTEGER DEFAULT 0,

    CONSTRAINT "PartiesInProjects_pkey" PRIMARY KEY ("projectId","partyId")
);

-- CreateIndex
CREATE UNIQUE INDEX "Person_emailId_key" ON "Person"("emailId");

-- CreateIndex
CREATE UNIQUE INDEX "Person_phoneId_key" ON "Person"("phoneId");

-- CreateIndex
CREATE UNIQUE INDEX "User_personId_key" ON "User"("personId");

-- AddForeignKey
ALTER TABLE "User" ADD CONSTRAINT "User_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person"("personId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Org" ADD CONSTRAINT "Org_parentId_fkey" FOREIGN KEY ("parentId") REFERENCES "Org"("orgId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Person" ADD CONSTRAINT "Person_emailId_fkey" FOREIGN KEY ("emailId") REFERENCES "Email"("emailId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Person" ADD CONSTRAINT "Person_phoneId_fkey" FOREIGN KEY ("phoneId") REFERENCES "Phone"("phoneId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Person" ADD CONSTRAINT "Person_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Org"("orgId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PeopleInOrgs" ADD CONSTRAINT "PeopleInOrgs_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person"("personId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PeopleInOrgs" ADD CONSTRAINT "PeopleInOrgs_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Org"("orgId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Email" ADD CONSTRAINT "Email_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person"("personId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Phone" ADD CONSTRAINT "Phone_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person"("personId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Project" ADD CONSTRAINT "Project_createdByUserId_fkey" FOREIGN KEY ("createdByUserId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Project" ADD CONSTRAINT "Project_updatedbyUserId_fkey" FOREIGN KEY ("updatedbyUserId") REFERENCES "User"("userId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertiesInProjects" ADD CONSTRAINT "PropertiesInProjects_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("propertyId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PropertiesInProjects" ADD CONSTRAINT "PropertiesInProjects_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("projectId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Party" ADD CONSTRAINT "Party_personId_fkey" FOREIGN KEY ("personId") REFERENCES "Person"("personId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Party" ADD CONSTRAINT "Party_orgId_fkey" FOREIGN KEY ("orgId") REFERENCES "Org"("orgId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartiesInProjects" ADD CONSTRAINT "PartiesInProjects_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("projectId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "PartiesInProjects" ADD CONSTRAINT "PartiesInProjects_partyId_fkey" FOREIGN KEY ("partyId") REFERENCES "Party"("partyId") ON DELETE RESTRICT ON UPDATE CASCADE;
