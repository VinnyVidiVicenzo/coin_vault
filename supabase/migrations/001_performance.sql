-- ============================================================
-- Coin Vault — Performance migrations
-- Run these in the Supabase SQL editor (Dashboard → SQL Editor)
-- ============================================================

-- ── 1. Full-text search vector on items ──────────────────────
-- Adds a stored tsvector column covering all searchable text
-- fields, then builds a GIN index for instant text search.

ALTER TABLE items
ADD COLUMN IF NOT EXISTS search_vector tsvector
GENERATED ALWAYS AS (
  to_tsvector('english',
    coalesce(denomination,       '') || ' ' ||
    coalesce(country,            '') || ' ' ||
    coalesce(series,             '') || ' ' ||
    coalesce(variety,            '') || ' ' ||
    coalesce(grade,              '') || ' ' ||
    coalesce(cert_number,        '') || ' ' ||
    coalesce(serial_number,      '') || ' ' ||
    coalesce(issuing_authority,  '') || ' ' ||
    coalesce(mint_mark,          '') || ' ' ||
    coalesce(historical_context, '') || ' ' ||
    coalesce(attribution_notes,  '') || ' ' ||
    coalesce(internal_notes,     '')
  )
) STORED;

CREATE INDEX IF NOT EXISTS items_search_vector_idx
  ON items USING GIN (search_vector);

-- Supporting B-tree indexes for the ILIKE fallback path
CREATE INDEX IF NOT EXISTS items_country_idx
  ON items (country text_pattern_ops);
CREATE INDEX IF NOT EXISTS items_denomination_idx
  ON items (denomination text_pattern_ops);
CREATE INDEX IF NOT EXISTS items_cert_number_idx
  ON items (cert_number text_pattern_ops);
CREATE INDEX IF NOT EXISTS items_serial_number_idx
  ON items (serial_number text_pattern_ops);

-- ── 2. Total cost generated column on acquisition ─────────────
-- Automatically kept in sync; avoids summing in application code.

ALTER TABLE acquisition
ADD COLUMN IF NOT EXISTS total_cost NUMERIC(14, 2)
GENERATED ALWAYS AS (
  coalesce(purchase_price,  0) +
  coalesce(buyers_premium,  0) +
  coalesce(shipping_cost,   0) +
  coalesce(tax_paid,        0) +
  coalesce(other_fees,      0)
) STORED;

-- ── 3. current_valuations view ────────────────────────────────
-- Returns the most-recent valuation record per item.
-- Relies on RLS from the underlying valuation_history table,
-- so each user only sees their own rows.

CREATE OR REPLACE VIEW current_valuations AS
SELECT DISTINCT ON (vh.item_id)
  vh.id,
  vh.item_id,
  vh.owner_id,
  vh.valuation_date,
  vh.estimated_value,
  vh.currency,
  vh.value_type,
  vh.value_source,
  vh.confidence,
  vh.notes,
  vh.created_at
FROM valuation_history vh
ORDER BY vh.item_id, vh.valuation_date DESC, vh.created_at DESC;

-- ── 4. Additional helpful indexes ────────────────────────────
CREATE INDEX IF NOT EXISTS items_owner_type_idx
  ON items (owner_id, item_type);
CREATE INDEX IF NOT EXISTS items_owner_updated_idx
  ON items (owner_id, updated_at DESC);
CREATE INDEX IF NOT EXISTS valuation_history_item_date_idx
  ON valuation_history (item_id, valuation_date DESC);
CREATE INDEX IF NOT EXISTS acquisition_owner_idx
  ON acquisition (owner_id);
