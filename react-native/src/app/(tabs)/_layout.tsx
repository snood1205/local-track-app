import { Tabs } from "expo-router";
import { FC } from "react";
import { StyleSheet } from "react-native";

const TabLayout: FC = () => (
  <Tabs
    screenOptions={{
      tabBarStyle: styles.tabBar,
      tabBarLabelStyle: styles.tabBarLabel,
    }}
  >
    <Tabs.Screen name="index" options={{ title: "Home" }} />
    <Tabs.Screen name="vendors" options={{ title: "Vendors" }} />
    <Tabs.Screen name="track-info" options={{ title: "Track Info" }} />
  </Tabs>
);

const styles = StyleSheet.create({
  tabBar: {
    backgroundColor: "#f8f8f8",
    borderTopWidth: 1,
    borderTopColor: "#ddd",
  },
  tabBarLabel: {
    fontSize: 14,
    fontWeight: "600",
  },
});

export default TabLayout;
