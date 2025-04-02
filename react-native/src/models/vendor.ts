interface BaseVendor {
  name: string;
  slug: string;
}

export interface Vendor extends BaseVendor {
  category: string;
}

export type CategorizedVendor = BaseVendor;
