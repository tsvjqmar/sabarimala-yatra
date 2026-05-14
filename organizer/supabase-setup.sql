-- ═══════════════════════════════════════════════════════════════
-- Sabarimala Organizer — Supabase Setup
-- ═══════════════════════════════════════════════════════════════
-- Paste this ENTIRE script into Supabase SQL Editor and click Run.
-- It creates 3 tables, access rules, and real-time subscriptions.
-- Safe to re-run — uses IF NOT EXISTS.

-- ─── 1. PAYMENTS / LEDGER ───
CREATE TABLE IF NOT EXISTS payments (
  id         BIGSERIAL PRIMARY KEY,
  traveller_sn INTEGER NOT NULL,
  amount     NUMERIC NOT NULL,
  note       TEXT,
  ts         TIMESTAMPTZ DEFAULT NOW(),
  device_id  TEXT
);
CREATE INDEX IF NOT EXISTS payments_sn_idx ON payments(traveller_sn);

-- ─── 2. EXPENSES ───
CREATE TABLE IF NOT EXISTS expenses (
  id          BIGSERIAL PRIMARY KEY,
  date        DATE NOT NULL,
  category    TEXT NOT NULL,
  description TEXT,
  amount      NUMERIC NOT NULL,
  paid_by     TEXT,
  ts          TIMESTAMPTZ DEFAULT NOW(),
  device_id   TEXT
);
CREATE INDEX IF NOT EXISTS expenses_date_idx ON expenses(date);

-- ─── 3. TRAVELLER OVERRIDES ───
-- Only stores edits to the default TRAVELLERS list (e.g. updated Aadhar)
CREATE TABLE IF NOT EXISTS traveller_overrides (
  sn      INTEGER PRIMARY KEY,
  name    TEXT,
  age     INTEGER,
  aadhar  TEXT,
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- ─── 4. ROW LEVEL SECURITY ───
ALTER TABLE payments ENABLE ROW LEVEL SECURITY;
ALTER TABLE expenses ENABLE ROW LEVEL SECURITY;
ALTER TABLE traveller_overrides ENABLE ROW LEVEL SECURITY;

-- Drop existing policies if rerunning
DROP POLICY IF EXISTS "anon_read_payments" ON payments;
DROP POLICY IF EXISTS "anon_write_payments" ON payments;
DROP POLICY IF EXISTS "anon_read_expenses" ON expenses;
DROP POLICY IF EXISTS "anon_write_expenses" ON expenses;
DROP POLICY IF EXISTS "anon_read_overrides" ON traveller_overrides;
DROP POLICY IF EXISTS "anon_write_overrides" ON traveller_overrides;

-- Anyone with the anon key (which is shipped in the app) can read/write.
-- Group passcode adds a second layer at the app level.
CREATE POLICY "anon_read_payments"  ON payments  FOR SELECT USING (true);
CREATE POLICY "anon_write_payments" ON payments  FOR ALL    USING (true) WITH CHECK (true);
CREATE POLICY "anon_read_expenses"  ON expenses  FOR SELECT USING (true);
CREATE POLICY "anon_write_expenses" ON expenses  FOR ALL    USING (true) WITH CHECK (true);
CREATE POLICY "anon_read_overrides" ON traveller_overrides FOR SELECT USING (true);
CREATE POLICY "anon_write_overrides" ON traveller_overrides FOR ALL USING (true) WITH CHECK (true);

-- ─── 5. ENABLE REALTIME ───
-- Push updates to all connected clients within ~1 second.
BEGIN;
  DROP PUBLICATION IF EXISTS supabase_realtime;
  CREATE PUBLICATION supabase_realtime FOR TABLE payments, expenses, traveller_overrides;
COMMIT;

-- Done. Three tables ready, real-time enabled.
