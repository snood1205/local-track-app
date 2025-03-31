import { Stack } from "expo-router";
import { FC } from "react";

const RootLayout: FC = () => (
  <Stack>
    <Stack.Screen name="(tabs)" options={{ headerShown: false }} />
    <Stack.Screen name="+not-found" />
  </Stack>
);

export default RootLayout;
