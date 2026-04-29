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
}
