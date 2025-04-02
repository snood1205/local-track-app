import { Address } from "./address";

export interface Track {
  name: string;
  length: string; // stored as decimal in psql, so kept a string for precision
  lengthUnit: "mi" | "km" | "yd" | "ft" | "m";
  material: string;
  humanReadableLength: string; // e.g. "3.1 miles"
  address?: Address;
}
