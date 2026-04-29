class DbConstants {
  // Tables
  static const items = 'items';
  static const catalogReferences = 'catalog_references';
  static const acquisition = 'acquisition';
  static const valuationHistory = 'valuation_history';
  static const storageLocations = 'storage_locations';
  static const itemStorage = 'item_storage';
  static const itemImages = 'item_images';
  static const itemDocuments = 'item_documents';
  static const ebayListings = 'ebay_listings';

  // Item types
  static const itemTypes = ['coin', 'note', 'token', 'medal', 'set', 'lot'];

  // Grading companies
  static const gradingCompanies = [
    'PCGS', 'NGC', 'PMG', 'ANACS', 'ICG', 'CAC', 'Raw'
  ];

  // Common grade designations
  static const designations = [
    'Full Bands', 'Full Bell Lines', 'Full Head', 'Full Steps',
    'Deep Mirror Prooflike', 'Prooflike', 'Cameo', 'Deep Cameo',
    'Ultra Cameo', 'Star', 'EPQ', 'PPQ', 'NET',
  ];

  // Catalog systems
  static const catalogSystems = [
    'KM', 'Y', 'Pick', 'Friedberg', 'Overton', 'Sheldon',
    'VAM', 'Snow', 'Crawford', 'Schön', 'Breen', 'SCWC',
    'Judd', 'Pollock', 'Rulau', 'Conder', 'other',
  ];

  // Value sources
  static const valueSources = [
    'Red Book', 'Greysheet', 'Bluesheet', 'PCGS CoinFacts',
    'NGC Price Guide', 'PMG Price Guide', 'Heritage Auction Realized',
    'Stack\'s Bowers', 'Great Collections', 'eBay Sold',
    'Dealer Quote', 'CAC Sticker Premium', 'Insurance Appraisal', 'Other',
  ];

  // ── Browse Categories (mirrors Stack's Bowers / Great Collections) ──

  static const List<CollectionCategory> browseCategories = [
    CollectionCategory(
      id: 'us_coins',
      label: 'US Coins',
      icon: '🦅',
      subcategories: [
        'All US Coins',
        'Early American (Pre-1793)',
        'Half Cents (1793–1857)',
        'Large Cents (1793–1857)',
        'Flying Eagle Cents',
        'Indian Head Cents',
        'Lincoln Cents — Wheat',
        'Lincoln Cents — Memorial',
        'Lincoln Cents — Shield',
        'Two Cents & Three Cents',
        'Shield Nickels',
        'Liberty Nickels',
        'Buffalo Nickels',
        'Jefferson Nickels',
        'Half Dimes',
        'Bust Dimes',
        'Seated Liberty Dimes',
        'Barber Dimes',
        'Mercury Dimes',
        'Roosevelt Dimes',
        'Twenty Cents',
        'Bust Quarters',
        'Seated Liberty Quarters',
        'Barber Quarters',
        'Standing Liberty Quarters',
        'Washington Quarters',
        'State Quarters',
        'America the Beautiful Quarters',
        'American Women Quarters',
        'Bust Half Dollars',
        'Capped Bust Halves',
        'Seated Liberty Halves',
        'Barber Half Dollars',
        'Walking Liberty Halves',
        'Franklin Half Dollars',
        'Kennedy Half Dollars',
        'Bust Dollars',
        'Seated Liberty Dollars',
        'Trade Dollars',
        'Morgan Dollars',
        'Peace Dollars',
        'Eisenhower Dollars',
        'Susan B. Anthony Dollars',
        'Sacagawea Dollars',
        'Presidential Dollars',
        'American Innovation Dollars',
        'Gold — \$1 Gold',
        'Gold — \$2.50 Quarter Eagles',
        'Gold — \$5 Half Eagles',
        'Gold — \$10 Eagles',
        'Gold — \$20 Double Eagles',
        'Classic Commemoratives',
        'Modern Commemoratives',
        'Proof Sets',
        'Mint Sets',
        'American Silver Eagles',
        'American Gold Eagles',
        'American Platinum Eagles',
        'Errors & Varieties',
        'Patterns & Experimental',
      ],
    ),
    CollectionCategory(
      id: 'world_coins',
      label: 'World & Ancient',
      icon: '🌍',
      subcategories: [
        'All World & Ancient',
        'Africa',
        'Canada',
        'Mexico',
        'Central & South America',
        'Caribbean',
        'United Kingdom',
        'Western Europe',
        'Eastern Europe',
        'Russia & Soviet',
        'Middle East',
        'South Asia',
        'East Asia',
        'Southeast Asia',
        'Oceania',
        'Ancient Greek',
        'Ancient Roman — Republic',
        'Ancient Roman — Imperial',
        'Byzantine',
        'Medieval',
        'Islamic',
        'Celtic',
        'Other Ancient',
      ],
    ),
    CollectionCategory(
      id: 'paper_money',
      label: 'Paper Money',
      icon: '💵',
      subcategories: [
        'All Paper Money',
        'Colonial & Continental',
        'Continental Currency',
        'Demand Notes (1861)',
        'Legal Tender Notes',
        'Compound Interest Notes',
        'Interest Bearing Notes',
        'Refunding Certificates',
        'Silver Certificates',
        'Treasury / Coin Notes',
        'National Bank Notes',
        'Federal Reserve Bank Notes',
        'Federal Reserve Notes — Large',
        'Federal Reserve Notes — Small',
        'Gold Certificates',
        'Confederate Currency',
        'Obsolete Currency',
        'Military Payment Certificates',
        'Error Notes',
        'Star Notes',
        'World Banknotes — Africa',
        'World Banknotes — Americas',
        'World Banknotes — Asia',
        'World Banknotes — Europe',
        'World Banknotes — Middle East',
        'World Banknotes — Oceania',
      ],
    ),
    CollectionCategory(
      id: 'exonumia',
      label: 'Exonumia',
      icon: '🏅',
      subcategories: [
        'All Exonumia',
        'Hard Times Tokens',
        'Civil War Tokens',
        'Trade Tokens',
        'Transportation Tokens',
        'Good For Tokens',
        'Merchant Tokens',
        'Elongated Coins',
        'Encased Postage',
        'So-Called Dollars',
        'Medals — Military',
        'Medals — Political',
        'Medals — Commemorative',
        'Badges & Ribbons',
        'Scrip',
        'Casino Chips',
        'Other Exonumia',
      ],
    ),
  ];

  // Grade ranges for filter (Sheldon scale)
  static const List<GradeRange> gradeRanges = [
    GradeRange(label: 'Poor (P-1)', min: 1, max: 1),
    GradeRange(label: 'Fair (F-2)', min: 2, max: 2),
    GradeRange(label: 'About Good (AG-3)', min: 3, max: 3),
    GradeRange(label: 'Good (G-4 to G-6)', min: 4, max: 6),
    GradeRange(label: 'Very Good (VG-8 to VG-10)', min: 8, max: 10),
    GradeRange(label: 'Fine (F-12 to F-15)', min: 12, max: 15),
    GradeRange(label: 'Very Fine (VF-20 to VF-35)', min: 20, max: 35),
    GradeRange(label: 'Extremely Fine (EF-40 to EF-45)', min: 40, max: 45),
    GradeRange(label: 'About Uncirculated (AU-50 to AU-58)', min: 50, max: 58),
    GradeRange(label: 'Mint State (MS-60 to MS-62)', min: 60, max: 62),
    GradeRange(label: 'Mint State (MS-63 to MS-64)', min: 63, max: 64),
    GradeRange(label: 'Mint State Choice (MS-65 to MS-66)', min: 65, max: 66),
    GradeRange(label: 'Mint State Gem (MS-67+)', min: 67, max: 70),
    GradeRange(label: 'Proof (PR/PF-60 to PR-64)', min: 60, max: 64),
    GradeRange(label: 'Proof Gem (PR/PF-65+)', min: 65, max: 70),
  ];

  // Common mint marks
  static const mintMarks = [
    'No Mint Mark (P)',
    'P — Philadelphia',
    'D — Denver',
    'S — San Francisco',
    'O — New Orleans',
    'CC — Carson City',
    'W — West Point',
    'C — Charlotte',
    'D — Dahlonega (Gold)',
    'Other',
  ];

  // Metals
  static const metals = [
    'Silver', 'Gold', 'Copper', 'Bronze', 'Nickel',
    'Clad', 'Platinum', 'Palladium', 'Bimetallic',
    'Lead', 'Iron', 'Brass', 'Aluminum', 'Paper', 'Other',
  ];
}

class CollectionCategory {
  final String id;
  final String label;
  final String icon;
  final List<String> subcategories;

  const CollectionCategory({
    required this.id,
    required this.label,
    required this.icon,
    required this.subcategories,
  });
}

class GradeRange {
  final String label;
  final int min;
  final int max;
  const GradeRange({required this.label, required this.min, required this.max});
}
