-- CreateTable
CREATE TABLE "User" (
    "UserId" SERIAL NOT NULL,
    "FirstName" TEXT NOT NULL,
    "LastName" TEXT,
    "Email" TEXT NOT NULL,
    "Password" TEXT NOT NULL,
    "Avatar" TEXT,
    "Role" TEXT NOT NULL DEFAULT E'user',
    "CreatedAt" TIMESTAMP(3) NOT NULL DEFAULT now(),

    CONSTRAINT "User_pkey" PRIMARY KEY ("UserId")
);
