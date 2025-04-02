import { MD5, NotUndefined } from "object-hash";

const storedHashes = new WeakMap<object, string>();
const md5 = (object: NotUndefined) => {
  if (typeof object === "object" && object !== null) {
    if (storedHashes.has(object)) {
      return storedHashes.get(object);
    }
    const hash = MD5(object);
    storedHashes.set(object, hash);
    return hash;
  }
  return MD5(object);
};

export const md5key = (object: NotUndefined, text: string): string => {
  const hash = md5(object);
  return `${hash}-${text}`;
};
