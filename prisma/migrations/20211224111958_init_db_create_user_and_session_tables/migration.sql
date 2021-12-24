-- CreateEnum
CREATE TYPE "Role" AS ENUM ('GUEST', 'USER', 'ADMIN');

-- CreateTable
CREATE TABLE "User" (
    "userId" SERIAL NOT NULL,
    "firstName" VARCHAR(255),
    "lastName" VARCHAR(255),
    "email" TEXT NOT NULL,
    "password" VARCHAR(255) NOT NULL,
    "avatar" VARCHAR(255),
    "role" "Role" NOT NULL DEFAULT E'USER',
    "createdAt" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "User_pkey" PRIMARY KEY ("userId")
);

-- CreateTable
CREATE TABLE "Session" (
    "sessionId" TEXT NOT NULL,
    "userId" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");

-- CreateIndex
CREATE UNIQUE INDEX "Session_sessionId_key" ON "Session"("sessionId");

-- AddForeignKey
ALTER TABLE "Session" ADD CONSTRAINT "Session_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User"("userId") ON DELETE RESTRICT ON UPDATE CASCADE;
