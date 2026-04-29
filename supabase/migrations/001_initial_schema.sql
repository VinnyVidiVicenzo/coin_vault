-- ============================================================
-- Coin Vault — Initial Schema
-- Run this in your Supabase SQL editor to set up the database.
-- ============================================================

-- ──────────────────────────────────────────────────────────────
-- PROFILES
-- ──────────────────────────────────────────────────────────────
CREATE TABLE profiles (
  id           uuid PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
  display_name text,
  created_at   timestamptz DEFAULT now()
);

CREATE OR REPLACE FUNCTION handle_new_user()
RETURNS trigger LANGUAGE plpgsql SECURITY DEFINER AS $$
BEGIN
  INSERT INTO public.profiles (id, display_name)
  VALUES (NEW.id, NEW.email);
  RETURN NEW;
END;
$$;

CREATE TRIGGER on_auth_user_created
  AFTER INSERT ON auth.users
  FOR EACH ROW EXECUTE PROCEDURE handle_new_user();

-- ──────────────────────────────────────────────────────────────
-- ITEMS (central catalog)
-- ──────────────────────────────────────────────────────────────
CREATE TABLE items (
  id                    uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id              uuid NOT NULL REFERENCES profiles(id) ON DELETE CASCADE,

  -- Identity
  item_type             text NOT NULL DEFAULT 'coin'
                          CHECK (item_type IN ('coin','note','token','medal','set','lot')),
  country               text,
  issuing_authority     text,
  denomination          text,
  denomination_numeric  numeric,
  year_start            integer,
  year_end              integer,
  mint_mark             text,
  series                text,
  variety               text,
  is_public             boolean NOT NULL DEFAULT false,

  -- Physical — coins
  metal                 text,
  weight_grams          numeric,
  diameter_mm           numeric,
  edge_type             text,
  coin_orientation      text,

  -- Physical — notes
  note_width_mm         numeric,
  note_height_mm        numeric,

  -- Coin-specific descriptions
  obverse_description   text,
  reverse_description   text,
  edge_description      text,
  die_markers           text,

  -- Note-specific fields
  serial_number         text,
  serial_block          text,
  signature_combination text,
  seal_color            text,
  district              text,
  plate_number_front    text,
  plate_number_back     text,
  is_star_note          boolean DEFAULT false,

  -- Condition
  grade                 text,
  grade_numeric         numeric,
  grading_company       text,
  cert_number           text,
  is_slabbed            boolean DEFAULT false,
  details_grade         boolean DEFAULT false,
  details_note          text,
  defects               text[] DEFAULT '{}',

  -- Certification extended
  designation           text,
  holder_generation     text,
  population_obverse    integer,
  population_reverse    integer,
  cert_verification_url text,
  submission_status     text DEFAULT 'raw'
                          CHECK (submission_status IN
                            ('raw','submitted','returned','crossed','reholdered')),

  -- Quantity
  quantity_type         text DEFAULT 'single'
                          CHECK (quantity_type IN
                            ('single','roll','partial_roll','lot','set')),
  quantity              integer DEFAULT 1,
  duplicate_count       integer DEFAULT 0,

  -- Research / notes
  historical_context    text,
  attribution_notes     text,
  provenance            text,
  research_links        text[] DEFAULT '{}',
  internal_notes        text,

  created_at            timestamptz DEFAULT now(),
  updated_at            timestamptz DEFAULT now()
);

CREATE INDEX idx_items_owner ON items (owner_id);
CREATE INDEX idx_items_type ON items (item_type);
CREATE INDEX idx_items_country ON items (country);
CREATE INDEX idx_items_public ON items (is_public) WHERE is_public = true;
CREATE INDEX idx_items_updated ON items (owner_id, updated_at DESC);

-- Full-text search
ALTER TABLE items ADD COLUMN search_vector tsvector
  GENERATED ALWAYS AS (
    to_tsvector('english',
      coalesce(country,'') || ' ' ||
      coalesce(denomination,'') || ' ' ||
      coalesce(variety,'') || ' ' ||
      coalesce(series,'') || ' ' ||
      coalesce(mint_mark,'') || ' ' ||
      coalesce(grade,'') || ' ' ||
      coalesce(grading_company,'') || ' ' ||
      coalesce(cert_number,'') || ' ' ||
      coalesce(historical_context,'') || ' ' ||
      coalesce(attribution_notes,'')
    )
  ) STORED;

CREATE INDEX idx_items_search ON items USING GIN (search_vector);

-- Auto-update updated_at
CREATE OR REPLACE FUNCTION update_updated_at()
RETURNS trigger LANGUAGE plpgsql AS $$
BEGIN NEW.updated_at = now(); RETURN NEW; END;
$$;
CREATE TRIGGER items_updated_at BEFORE UPDATE ON items
  FOR EACH ROW EXECUTE PROCEDURE update_updated_at();

-- ──────────────────────────────────────────────────────────────
-- CATALOG REFERENCES
-- ──────────────────────────────────────────────────────────────
CREATE TABLE catalog_references (
  id                     uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id                uuid NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  catalog_system         text NOT NULL,
  reference_number       text NOT NULL,
  variety_name           text,
  die_pair               text,
  attribution_confidence text CHECK (attribution_confidence IN
                            ('confirmed','likely','possible')),
  attribution_source     text,
  notes                  text,
  created_at             timestamptz DEFAULT now()
);

CREATE INDEX idx_catref_item ON catalog_references (item_id);
CREATE INDEX idx_catref_system ON catalog_references (catalog_system, reference_number);

-- ──────────────────────────────────────────────────────────────
-- ACQUISITION
-- ──────────────────────────────────────────────────────────────
CREATE TABLE acquisition (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id         uuid NOT NULL UNIQUE REFERENCES items(id) ON DELETE CASCADE,
  owner_id        uuid NOT NULL REFERENCES profiles(id),

  purchase_date   date,
  source_type     text CHECK (source_type IN (
                    'dealer','auction','estate','trade','gift',
                    'inherited','found','unknown')),
  seller_name     text,
  seller_contact  text,
  lot_number      text,

  purchase_price  numeric,
  buyers_premium  numeric,
  shipping_cost   numeric,
  tax_paid        numeric,
  other_fees      numeric,
  total_cost      numeric GENERATED ALWAYS AS (
                    COALESCE(purchase_price,0) + COALESCE(buyers_premium,0) +
                    COALESCE(shipping_cost,0) + COALESCE(tax_paid,0) +
                    COALESCE(other_fees,0)
                  ) STORED,

  currency        text DEFAULT 'USD',
  payment_method  text,
  cost_basis_type text DEFAULT 'known' CHECK (cost_basis_type IN (
                    'known','gifted','inherited','found','unknown')),

  notes           text,
  created_at      timestamptz DEFAULT now()
);

CREATE INDEX idx_acquisition_item ON acquisition (item_id);
CREATE INDEX idx_acquisition_owner ON acquisition (owner_id);

-- ──────────────────────────────────────────────────────────────
-- VALUATION HISTORY
-- ──────────────────────────────────────────────────────────────
CREATE TABLE valuation_history (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id         uuid NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  owner_id        uuid NOT NULL REFERENCES profiles(id),

  valuation_date  date NOT NULL,
  estimated_value numeric NOT NULL,
  currency        text DEFAULT 'USD',
  value_type      text NOT NULL CHECK (value_type IN (
                    'retail','wholesale','auction_realized',
                    'insurance','dealer_quote','cac_sticker_premium')),
  value_source    text NOT NULL,
  confidence      text CHECK (confidence IN ('low','medium','high')),
  notes           text,
  created_at      timestamptz DEFAULT now()
);

CREATE INDEX idx_valuation_item_date ON valuation_history (item_id, valuation_date DESC);
CREATE INDEX idx_valuation_owner ON valuation_history (owner_id);

CREATE VIEW current_valuations AS
SELECT DISTINCT ON (item_id)
  id, item_id, valuation_date, estimated_value, currency,
  value_type, value_source, confidence, notes
FROM valuation_history
ORDER BY item_id, valuation_date DESC;

-- ──────────────────────────────────────────────────────────────
-- STORAGE LOCATIONS (PRIVATE — zero public RLS policy)
-- ──────────────────────────────────────────────────────────────
CREATE TABLE storage_locations (
  id                uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  owner_id          uuid NOT NULL REFERENCES profiles(id),

  location_name     text NOT NULL,
  location_type     text CHECK (location_type IN (
                      'home_safe','bank_box','display','storage_unit','other')),
  address_notes     text,
  environment_notes text,
  is_active         boolean DEFAULT true,
  created_at        timestamptz DEFAULT now()
);

CREATE INDEX idx_storageloc_owner ON storage_locations (owner_id);

-- ──────────────────────────────────────────────────────────────
-- ITEM STORAGE (PRIVATE)
-- ──────────────────────────────────────────────────────────────
CREATE TABLE item_storage (
  id                    uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id               uuid NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  owner_id              uuid NOT NULL REFERENCES profiles(id),
  storage_location_id   uuid NOT NULL REFERENCES storage_locations(id),

  container_type        text,
  container_label       text,
  slot_envelope_number  text,
  holder_type           text CHECK (holder_type IN (
                          '2x2','flip','slab','capsule','album_page',
                          'currency_sleeve','original_holder','other')),
  environment_notes     text,
  last_verified_date    date,
  notes                 text,
  created_at            timestamptz DEFAULT now(),
  updated_at            timestamptz DEFAULT now()
);

CREATE INDEX idx_itemstorage_item ON item_storage (item_id);
CREATE INDEX idx_itemstorage_owner ON item_storage (owner_id);
CREATE INDEX idx_itemstorage_location ON item_storage (storage_location_id);

CREATE TRIGGER item_storage_updated_at BEFORE UPDATE ON item_storage
  FOR EACH ROW EXECUTE PROCEDURE update_updated_at();

-- ──────────────────────────────────────────────────────────────
-- ITEM IMAGES
-- ──────────────────────────────────────────────────────────────
CREATE TABLE item_images (
  id            uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id       uuid NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  owner_id      uuid NOT NULL REFERENCES profiles(id),

  image_type    text NOT NULL CHECK (image_type IN (
                  'obverse','reverse','edge','mint_mark_closeup',
                  'variety_diagnostic','slab_front','slab_back',
                  'receipt','auction_screenshot','prior_owner_tag','other')),
  storage_path  text NOT NULL,
  public_url    text,
  is_public     boolean DEFAULT false,
  display_order integer DEFAULT 0,
  caption       text,
  created_at    timestamptz DEFAULT now()
);

CREATE INDEX idx_images_item ON item_images (item_id);
CREATE INDEX idx_images_public ON item_images (item_id, is_public);

-- ──────────────────────────────────────────────────────────────
-- ITEM DOCUMENTS
-- ──────────────────────────────────────────────────────────────
CREATE TABLE item_documents (
  id              uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id         uuid NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  owner_id        uuid NOT NULL REFERENCES profiles(id),

  document_type   text CHECK (document_type IN (
                    'invoice','receipt','population_report',
                    'auction_catalog','appraisal','other')),
  storage_path    text NOT NULL,
  filename        text,
  file_size_bytes bigint,
  notes           text,
  created_at      timestamptz DEFAULT now()
);

CREATE INDEX idx_docs_item ON item_documents (item_id);

-- ──────────────────────────────────────────────────────────────
-- EBAY LISTINGS
-- ──────────────────────────────────────────────────────────────
CREATE TABLE ebay_listings (
  id                    uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  item_id               uuid NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  owner_id              uuid NOT NULL REFERENCES profiles(id),

  listing_url           text,
  ebay_item_number      text,
  listing_status        text NOT NULL DEFAULT 'draft' CHECK (listing_status IN (
                          'draft','active','sold','ended','relisted','cancelled')),

  list_price            numeric,
  best_offer_min        numeric,
  sold_price            numeric,
  sold_date             date,
  buyer_username        text,

  shipping_charged      numeric,
  ebay_final_value_fee  numeric,
  ebay_ad_fee           numeric,
  paypal_fee            numeric,
  other_fees            numeric,
  net_proceeds          numeric GENERATED ALWAYS AS (
                          COALESCE(sold_price,0)
                          - COALESCE(ebay_final_value_fee,0)
                          - COALESCE(ebay_ad_fee,0)
                          - COALESCE(paypal_fee,0)
                          - COALESCE(other_fees,0)
                        ) STORED,

  listed_date           date,
  ended_date            date,
  notes                 text,
  created_at            timestamptz DEFAULT now(),
  updated_at            timestamptz DEFAULT now()
);

CREATE INDEX idx_ebay_item ON ebay_listings (item_id);
CREATE INDEX idx_ebay_owner ON ebay_listings (owner_id);
CREATE INDEX idx_ebay_status ON ebay_listings (owner_id, listing_status);

CREATE TRIGGER ebay_updated_at BEFORE UPDATE ON ebay_listings
  FOR EACH ROW EXECUTE PROCEDURE update_updated_at();

-- ============================================================
-- ROW LEVEL SECURITY
-- ============================================================

ALTER TABLE profiles          ENABLE ROW LEVEL SECURITY;
ALTER TABLE items             ENABLE ROW LEVEL SECURITY;
ALTER TABLE catalog_references ENABLE ROW LEVEL SECURITY;
ALTER TABLE acquisition       ENABLE ROW LEVEL SECURITY;
ALTER TABLE valuation_history ENABLE ROW LEVEL SECURITY;
ALTER TABLE storage_locations ENABLE ROW LEVEL SECURITY;
ALTER TABLE item_storage      ENABLE ROW LEVEL SECURITY;
ALTER TABLE item_images       ENABLE ROW LEVEL SECURITY;
ALTER TABLE item_documents    ENABLE ROW LEVEL SECURITY;
ALTER TABLE ebay_listings     ENABLE ROW LEVEL SECURITY;

-- profiles
CREATE POLICY profiles_owner ON profiles FOR ALL USING (auth.uid() = id);

-- items: owner full access; anonymous read-only for public items
CREATE POLICY items_owner ON items FOR ALL USING (auth.uid() = owner_id);
CREATE POLICY items_public_read ON items FOR SELECT USING (is_public = true);

-- catalog_references: follows item visibility
CREATE POLICY catref_owner ON catalog_references FOR ALL USING (
  EXISTS (SELECT 1 FROM items WHERE items.id = item_id AND items.owner_id = auth.uid())
);
CREATE POLICY catref_public_read ON catalog_references FOR SELECT USING (
  EXISTS (SELECT 1 FROM items WHERE items.id = item_id AND items.is_public = true)
);

-- acquisition: owner only
CREATE POLICY acquisition_owner ON acquisition FOR ALL USING (auth.uid() = owner_id);

-- valuation_history: owner only
CREATE POLICY valuation_owner ON valuation_history FOR ALL USING (auth.uid() = owner_id);

-- storage_locations: owner only — NO public policy
CREATE POLICY storageloc_owner ON storage_locations FOR ALL USING (auth.uid() = owner_id);

-- item_storage: owner only — NO public policy
CREATE POLICY itemstorage_owner ON item_storage FOR ALL USING (auth.uid() = owner_id);

-- item_images: owner full access; anonymous read-only for public images
CREATE POLICY images_owner ON item_images FOR ALL USING (auth.uid() = owner_id);
CREATE POLICY images_public_read ON item_images FOR SELECT USING (is_public = true);

-- item_documents: owner only
CREATE POLICY docs_owner ON item_documents FOR ALL USING (auth.uid() = owner_id);

-- ebay_listings: owner only
CREATE POLICY ebay_owner ON ebay_listings FOR ALL USING (auth.uid() = owner_id);

-- ============================================================
-- PUBLIC API FUNCTION (used by WordPress plugin)
-- Returns only safe public fields — storage data excluded.
-- ============================================================

CREATE OR REPLACE FUNCTION public_collection(
  p_limit  int  DEFAULT 20,
  p_offset int  DEFAULT 0,
  p_type   text DEFAULT NULL,
  p_country text DEFAULT NULL
)
RETURNS TABLE (
  id                   uuid,
  item_type            text,
  country              text,
  issuing_authority    text,
  denomination         text,
  year_start           integer,
  year_end             integer,
  mint_mark            text,
  series               text,
  variety              text,
  metal                text,
  grade                text,
  grading_company      text,
  cert_number          text,
  is_slabbed           boolean,
  designation          text,
  cert_verification_url text,
  submission_status    text,
  historical_context   text,
  attribution_notes    text,
  provenance           text,
  created_at           timestamptz
)
LANGUAGE sql SECURITY DEFINER AS $$
  SELECT
    i.id, i.item_type, i.country, i.issuing_authority, i.denomination,
    i.year_start, i.year_end, i.mint_mark, i.series, i.variety, i.metal,
    i.grade, i.grading_company, i.cert_number, i.is_slabbed, i.designation,
    i.cert_verification_url, i.submission_status,
    i.historical_context, i.attribution_notes, i.provenance,
    i.created_at
  FROM items i
  WHERE i.is_public = true
    AND (p_type IS NULL OR i.item_type = p_type)
    AND (p_country IS NULL OR i.country ILIKE '%' || p_country || '%')
  ORDER BY i.created_at DESC
  LIMIT p_limit OFFSET p_offset;
$$;
