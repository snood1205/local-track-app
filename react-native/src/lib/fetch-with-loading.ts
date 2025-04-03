import { Dispatch, SetStateAction } from "react";

export const fetchWithLoading =
  <T>(
    endpoint: `/${string}`,
    setStateAction: Dispatch<SetStateAction<T>>,
    setLoading: Dispatch<SetStateAction<boolean>>,
  ) =>
  async () => {
    const url = `${process.env.EXPO_PUBLIC_API_URL}${endpoint}`;
    const response = await fetch(url);
    const json = await response.json();
    setStateAction(json);
    setLoading(false);
  };
