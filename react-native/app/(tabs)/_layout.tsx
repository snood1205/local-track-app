import { Tabs } from "expo-router";
import { FC } from "react";

const TabLayout: FC = () => (
  <Tabs>
    <Tabs.Screen name="index" options={{ title: "Home" }} />
  </Tabs>
);
