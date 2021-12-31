/*
  Warnings:

  - You are about to drop the column `street1` on the `Property` table. All the data in the column will be lost.
  - You are about to drop the column `street2` on the `Property` table. All the data in the column will be lost.

*/
-- AlterTable
ALTER TABLE "Property" DROP COLUMN "street1",
DROP COLUMN "street2",
ADD COLUMN     "street" VARCHAR(255);
