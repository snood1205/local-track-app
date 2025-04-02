import { MenuItem } from "./menu-item";

interface BaseVendor {
  name: string;
  slug: string;
}

export interface Vendor extends BaseVendor {
  category: string;
}

export interface VendorWithMenu extends Vendor {
  menu: Record<string, MenuItem[]>;
}

export type CategorizedVendor = BaseVendor;
