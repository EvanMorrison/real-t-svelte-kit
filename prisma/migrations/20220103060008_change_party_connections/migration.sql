/*
  Warnings:

  - You are about to drop the `Connection` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "Connection" DROP CONSTRAINT "Connection_partyId_fkey";

-- DropTable
DROP TABLE "Connection";

-- CreateTable
CREATE TABLE "_ManagesToManagedBy" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL
);

-- CreateIndex
CREATE UNIQUE INDEX "_ManagesToManagedBy_AB_unique" ON "_ManagesToManagedBy"("A", "B");

-- CreateIndex
CREATE INDEX "_ManagesToManagedBy_B_index" ON "_ManagesToManagedBy"("B");

-- AddForeignKey
ALTER TABLE "Party" ADD FOREIGN KEY ("partyId") REFERENCES "Party"("partyId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "Party" ADD FOREIGN KEY ("partyId") REFERENCES "Party"("partyId") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ManagesToManagedBy" ADD FOREIGN KEY ("A") REFERENCES "Party"("partyId") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "_ManagesToManagedBy" ADD FOREIGN KEY ("B") REFERENCES "Party"("partyId") ON DELETE CASCADE ON UPDATE CASCADE;
