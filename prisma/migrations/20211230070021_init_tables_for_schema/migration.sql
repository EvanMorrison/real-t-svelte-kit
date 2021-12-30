-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('GUEST', 'USER', 'ADMIN');

-- CreateTable
CREATE TABLE "User" (
    "userId" SERIAL NOT NULL,
    "firstName" VARCHAR(255),
    "lastName" VARCHAR(255),
    "email" TEXT NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "avatar" VARCHAR(255),
    "role" "UserRole" NOT NULL DEFAULT E'USER',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Session" (
    "sessionId" TEXT NOT NULL,
    "userId" INTEGER NOT NULL
);

-- CreateTable
CREATE TABLE "Contact" (
    "contactId" SERIAL NOT NULL,
    "prefix" TEXT DEFAULT E'',
    "firstName" TEXT DEFAULT E'',
    "lastName" TEXT DEFAULT E'',
    "fullName" TEXT DEFAULT E'',
    "suffix" TEXT DEFAULT E'',
    "nickname" TEXT DEFAULT E'',
    "email" TEXT DEFAULT E'',
    "phone" TEXT DEFAULT E'',
    "org" TEXT DEFAULT E'',
    "title" TEXT DEFAULT E'',
    "street" TEXT DEFAULT E'',
    "city" TEXT DEFAULT E'',
    "state" TEXT DEFAULT E'',
    "zipCode" TEXT DEFAULT E'',
    "avatar" TEXT DEFAULT E'',

    CONSTRAINT "Contact_pkey" PRIMARY KEY ("contactId")
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

    CONSTRAINT "Project_pkey" PRIMARY KEY ("projectId")
);

-- CreateTable
CREATE TABLE "ParcelsInProjects" (
    "propertyId" INTEGER NOT NULL,
    "projectId" INTEGER NOT NULL,
    "vesting" TEXT,
    "assessedValue" INTEGER,
    "assessedYear" INTEGER,
    "updatedAt" TIMESTAMP(3) NOT NULL,

    CONSTRAINT "ParcelsInProjects_pkey" PRIMARY KEY ("propertyId","projectId")
);

-- CreateTable
CREATE TABLE "Connection" (
    "connectionId" SERIAL NOT NULL,
    "partyId" INTEGER NOT NULL,
    "isPeer" BOOLEAN NOT NULL DEFAULT true,
    "isSubordinate" BOOLEAN NOT NULL DEFAULT false,

    CONSTRAINT "Connection_pkey" PRIMARY KEY ("connectionId")
);

-- CreateTable
CREATE TABLE "Party" (
    "partyId" SERIAL NOT NULL,
    "contactId" INTEGER NOT NULL,
    "projectId" INTEGER NOT NULL,
    "role" TEXT DEFAULT E'',

    CONSTRAINT "Party_pkey" PRIMARY KEY ("partyId")
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Session_sessionId_key" ON "Session"("sessionId");

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Project" ADD CONSTRAINT "Project_createdByUserId_fkey" FOREIGN KEY ("createdByUserId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Project" ADD CONSTRAINT "Project_updatedbyUserId_fkey" FOREIGN KEY ("updatedbyUserId") REFERENCES "User"("userId") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ParcelsInProjects" ADD CONSTRAINT "ParcelsInProjects_propertyId_fkey" FOREIGN KEY ("propertyId") REFERENCES "Property"("propertyId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ParcelsInProjects" ADD CONSTRAINT "ParcelsInProjects_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("projectId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Connection" ADD CONSTRAINT "Connection_partyId_fkey" FOREIGN KEY ("partyId") REFERENCES "Party"("partyId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Party" ADD CONSTRAINT "Party_contactId_fkey" FOREIGN KEY ("contactId") REFERENCES "Contact"("contactId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Party" ADD CONSTRAINT "Party_projectId_fkey" FOREIGN KEY ("projectId") REFERENCES "Project"("projectId") ON DELETE RESTRICT ON UPDATE CASCADE;
