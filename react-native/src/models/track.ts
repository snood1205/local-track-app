export interface Track {
  name: string;
  length: string; // stored as decimal in psql, so kept a string for precision
  length_unit: "mi" | "km" | "yd" | "ft" | "m";
  human_readable_length: string; // e.g. "3.1 miles"
}
